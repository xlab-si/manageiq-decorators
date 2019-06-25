module ManageIQ::Providers::Redfish
  class PhysicalInfraManager::PhysicalServerDecorator < MiqDecorator
    def fileicon
      "svg/vendor-#{vendor_label}.svg"
    end

  def self.fonticon
    'pficon pficon-server'
  end

  def quadicon
    icon = {
      :top_left     => {:text => (host ? 1 : 0)},
      :top_right    => {
        :tooltip => power_state.try(:downcase)
      }.merge(QuadiconHelper.machine_state(power_state)),
      :bottom_left  => {
        :fileicon => fileicon,
        :tooltip  => ui_lookup(:model => type)
      },
      :bottom_right => QuadiconHelper.health_state(health_state)
    }
    icon[:middle] = QuadiconHelper::POLICY_SHIELD if get_policies.present?
    icon
  end

  def single_quad
    {
      :fileicon => fileicon
    }
  end

    private

    MANUFACTURER_PATTERNS = {
      "supermicro" => "supermicro",
      "dell"       => "dell",
      "hpe"        => "hpe",
    }.freeze

    def vendor_label
      manufacturer = asset_detail.manufacturer.downcase
      MANUFACTURER_PATTERNS.detect do |_label, needle|
        manufacturer.include?(needle)
      end.try(:first) || "unknown"
    end
  end
end
