
CP=/bin/cp
MKDIR=/bin/mkdir
FIREWALL_ETC_DIR=/etc/firewall
FIREWALL_CONF=firewall.conf

firewall:
	$(CP) scripts/firewall /etc/init.d/firewall
	$(MKDIR) -p $(FIREWALL_ETC_DIR)
	$(CP) etc/$(FIREWALL_CONF) $(FIREWALL_ETC_DIR)/
