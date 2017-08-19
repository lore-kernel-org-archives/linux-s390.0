Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Subject: [07/15] mux: make device_type const
From: Bhumika Goyal <bhumirks@gmail.com>
Message-Id: <1503130946-2854-8-git-send-email-bhumirks@gmail.com>
Date: Sat, 19 Aug 2017 13:52:18 +0530
List-Archive: <https://lore.kernel.org/linux-edac/>
List-Post: <mailto:linux-edac@vger.kernel.org>
To: julia.lawall@lip6.fr, bp@alien8.de, mchehab@kernel.org, daniel.vetter@intel.com, jani.nikula@linux.intel.com, seanpaul@chromium.org, airlied@linux.ie, g.liakhovetski@gmx.de, tomas.winkler@intel.com, dwmw2@infradead.org, computersforpeace@gmail.com, boris.brezillon@free-electrons.com, marek.vasut@gmail.com, richard@nod.at, cyrille.pitchen@wedev4u.fr, peda@axentia.se, kishon@ti.com, bhelgaas@google.com, thierry.reding@gmail.com, jonathanh@nvidia.com, dvhart@infradead.org, andy@infradead.org, ohad@wizery.com, bjorn.andersson@linaro.org, freude@de.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, jth@kernel.org, jejb@linux.vnet.ibm.com, martin.petersen@oracle.com, lduncan@suse.com, cleech@redhat.com, johan@kernel.org, elder@kernel.org, gregkh@linuxfoundation.org, heikki.krogerus@linux.intel.com, linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org, linux-mtd@lists.infradead.org, linux-pci@vger.kernel.org, linux-tegra@vger.kernel.org, platform-driver-x86@vger.kernel.org, linux-remoteproc@vger.kernel.org, linux-s390@vger.kernel.org, fcoe-devel@open-fcoe.org, linux-scsi@vger.kernel.org, open-iscsi@googlegroups.com, greybus-dev@lists.linaro.org, devel@driverdev.osuosl.org, linux-usb@vger.kernel.org
Cc: Bhumika Goyal <bhumirks@gmail.com>
List-ID: <linux-s390.vger.kernel.org>

TWFrZSB0aGlzIGNvbnN0IGFzIGl0IGlzIG9ubHkgc3RvcmVkIGluIHRoZSB0eXBlIGZpZWxkIG9m
IGEgZGV2aWNlCnN0cnVjdHVyZSwgd2hpY2ggaXMgY29uc3QuCkRvbmUgdXNpbmcgQ29jY2luZWxs
ZS4KClNpZ25lZC1vZmYtYnk6IEJodW1pa2EgR295YWwgPGJodW1pcmtzQGdtYWlsLmNvbT4KLS0t
CiBkcml2ZXJzL211eC9tdXgtY29yZS5jIHwgMiArLQogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0
aW9uKCspLCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9tdXgvbXV4LWNvcmUu
YyBiL2RyaXZlcnMvbXV4L211eC1jb3JlLmMKaW5kZXggMmZlOTZjNC4uNjhiZDE2ZCAxMDA2NDQK
LS0tIGEvZHJpdmVycy9tdXgvbXV4LWNvcmUuYworKysgYi9kcml2ZXJzL211eC9tdXgtY29yZS5j
CkBAIC01OCw3ICs1OCw3IEBAIHN0YXRpYyB2b2lkIG11eF9jaGlwX3JlbGVhc2Uoc3RydWN0IGRl
dmljZSAqZGV2KQogCWtmcmVlKG11eF9jaGlwKTsKIH0KIAotc3RhdGljIHN0cnVjdCBkZXZpY2Vf
dHlwZSBtdXhfdHlwZSA9IHsKK3N0YXRpYyBjb25zdCBzdHJ1Y3QgZGV2aWNlX3R5cGUgbXV4X3R5
cGUgPSB7CiAJLm5hbWUgPSAibXV4LWNoaXAiLAogCS5yZWxlYXNlID0gbXV4X2NoaXBfcmVsZWFz
ZSwKIH07Cg==
