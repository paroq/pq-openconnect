include $(PQ_FACTORY)/factory.mk

pq_part_name := openconnect-7.04
pq_part_file := $(pq_part_name).tar.gz

pq_openconnect_configuration_flags += --prefix=$(part_dir)
pq_openconnect_configuration_flags += --with-vpnc-script=$(part_dir)/libexec/vpnc-script

pkg_config_path=$(pq-libxml2-dir)/lib/pkgconfig

build-stamp: stage-stamp
	$(MAKE) -C $(pq_part_name) mkinstalldirs=$(part_dir)
	$(MAKE) -C $(pq_part_name) mkinstalldirs=$(part_dir) DESTDIR=$(stage_dir) install
	cp $(source_dir)/libexec/vpnc-script $(stage_dir)/$(part_dir)/libexec
	touch $@

stage-stamp: configure-stamp

configure-stamp: patch-stamp
	cd $(pq_part_name) && PKG_CONFIG_PATH=$(pkg_config_path) ./configure $(pq_openconnect_configuration_flags)
	touch $@

patch-stamp: unpack-stamp
	touch $@

unpack-stamp: $(pq_part_file)
	tar xf $(source_dir)/$(pq_part_file)
	touch $@
