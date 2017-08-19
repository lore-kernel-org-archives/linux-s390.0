Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Subject: [14/15] staging: greybus: make device_type const
From: Bhumika Goyal <bhumirks@gmail.com>
Message-Id: <1503130946-2854-15-git-send-email-bhumirks@gmail.com>
Date: Sat, 19 Aug 2017 13:52:25 +0530
List-Archive: <https://lore.kernel.org/linux-edac/>
List-Post: <mailto:linux-edac@vger.kernel.org>
To: julia.lawall@lip6.fr, bp@alien8.de, mchehab@kernel.org, daniel.vetter@intel.com, jani.nikula@linux.intel.com, seanpaul@chromium.org, airlied@linux.ie, g.liakhovetski@gmx.de, tomas.winkler@intel.com, dwmw2@infradead.org, computersforpeace@gmail.com, boris.brezillon@free-electrons.com, marek.vasut@gmail.com, richard@nod.at, cyrille.pitchen@wedev4u.fr, peda@axentia.se, kishon@ti.com, bhelgaas@google.com, thierry.reding@gmail.com, jonathanh@nvidia.com, dvhart@infradead.org, andy@infradead.org, ohad@wizery.com, bjorn.andersson@linaro.org, freude@de.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, jth@kernel.org, jejb@linux.vnet.ibm.com, martin.petersen@oracle.com, lduncan@suse.com, cleech@redhat.com, johan@kernel.org, elder@kernel.org, gregkh@linuxfoundation.org, heikki.krogerus@linux.intel.com, linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org, linux-mtd@lists.infradead.org, linux-pci@vger.kernel.org, linux-tegra@vger.kernel.org, platform-driver-x86@vger.kernel.org, linux-remoteproc@vger.kernel.org, linux-s390@vger.kernel.org, fcoe-devel@open-fcoe.org, linux-scsi@vger.kernel.org, open-iscsi@googlegroups.com, greybus-dev@lists.linaro.org, devel@driverdev.osuosl.org, linux-usb@vger.kernel.org
Cc: Bhumika Goyal <bhumirks@gmail.com>
List-ID: <linux-s390.vger.kernel.org>

TWFrZSB0aGlzIGNvbnN0IGFzIGl0IGlzIG9ubHkgc3RvcmVkIGluIHRoZSB0eXBlIGZpZWxkIG9m
IGEgZGV2aWNlCnN0cnVjdHVyZSwgd2hpY2ggaXMgY29uc3QuCkRvbmUgdXNpbmcgQ29jY2luZWxs
ZS4KClNpZ25lZC1vZmYtYnk6IEJodW1pa2EgR295YWwgPGJodW1pcmtzQGdtYWlsLmNvbT4KLS0t
CiBkcml2ZXJzL3N0YWdpbmcvZ3JleWJ1cy9nYnBoeS5jIHwgMiArLQogMSBmaWxlIGNoYW5nZWQs
IDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9zdGFn
aW5nL2dyZXlidXMvZ2JwaHkuYyBiL2RyaXZlcnMvc3RhZ2luZy9ncmV5YnVzL2dicGh5LmMKaW5k
ZXggNjAzZGU2Zi4uODBjMWRhOCAxMDA2NDQKLS0tIGEvZHJpdmVycy9zdGFnaW5nL2dyZXlidXMv
Z2JwaHkuYworKysgYi9kcml2ZXJzL3N0YWdpbmcvZ3JleWJ1cy9nYnBoeS5jCkBAIC02Niw3ICs2
Niw3IEBAIHN0YXRpYyBpbnQgZ2JfZ2JwaHlfaWRsZShzdHJ1Y3QgZGV2aWNlICpkZXYpCiAJCQkg
ICBnYl9nYnBoeV9pZGxlKQogfTsKIAotc3RhdGljIHN0cnVjdCBkZXZpY2VfdHlwZSBncmV5YnVz
X2dicGh5X2Rldl90eXBlID0geworc3RhdGljIGNvbnN0IHN0cnVjdCBkZXZpY2VfdHlwZSBncmV5
YnVzX2dicGh5X2Rldl90eXBlID0gewogCS5uYW1lCSA9CSJnYnBoeV9kZXZpY2UiLAogCS5yZWxl
YXNlID0JZ2JwaHlfZGV2X3JlbGVhc2UsCiAJLnBtCT0JJmdiX2dicGh5X3BtX29wcywK
