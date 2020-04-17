Return-Path: <linux-kernel-owner@vger.kernel.org>
From: "Derrick, Jonathan" <jonathan.derrick@intel.com>
Subject: Re: [PATCH v2 00/33] iommu: Move iommu_group setup to IOMMU core
 code
Date: Fri, 17 Apr 2020 01:14:30 +0000
Message-ID: <aafed865c0254934986528b3ce9c4d34ff2fccad.camel@intel.com>
References: <20200414131542.25608-1-joro@8bytes.org>
         <20200417010335.31739-1-drake@endlessm.com>
In-Reply-To: <20200417010335.31739-1-drake@endlessm.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <B8851D46B4E5F2468CD8AA858DAC2199@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: "joro@8bytes.org" <joro@8bytes.org>, "drake@endlessm.com" <drake@endlessm.com>
Cc: "heiko@sntech.de" <heiko@sntech.de>, "kgene@kernel.org" <kgene@kernel.org>, "jonathanh@nvidia.com" <jonathanh@nvidia.com>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>, "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>, "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>, "robin.murphy@arm.com" <robin.murphy@arm.com>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>, "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>, "thierry.reding@gmail.com" <thierry.reding@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "dwmw2@infradead.org" <dwmw2@infradead.org>, "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>, "m.szyprowski@samsung.com" <m.szyprowski@samsung.com>, "jean-philippe@linaro.org" <jean-philippe@linaro.org>, "will@kernel.org" <will@kernel.org>, "krzk@kernel.org" <krzk@kernel.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, "robdclark@gmail.com" <robdclark@gmail.com>, "gerald.schaefer@de.ibm.com" <gerald.schaefer@de.ibm.com>, "linux-rockchip@lists.infradead.org" <linux-rockchip@lists.infradead.org>, "agross@kernel.org" <agross@kernel.org>, "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>

SGkgRGFuaWVsLA0KDQpPbiBGcmksIDIwMjAtMDQtMTcgYXQgMDk6MDMgKzA4MDAsIERhbmllbCBE
cmFrZSB3cm90ZToNCj4gSGkgSm9lcmcsDQo+IA0KPiA+IEhpLA0KPiA+IA0KPiA+IGhlcmUgaXMg
dGhlIHNlY29uZCB2ZXJzaW9uIG9mIHRoaXMgcGF0Y2gtc2V0LiBUaGUgZmlyc3QgdmVyc2lvbiB3
aXRoDQo+ID4gc29tZSBtb3JlIGludHJvZHVjdG9yeSB0ZXh0IGNhbiBiZSBmb3VuZCBoZXJlOg0K
PiA+IA0KPiA+IAlodHRwczovL2xvcmUua2VybmVsLm9yZy9sa21sLzIwMjAwNDA3MTgzNzQyLjQz
NDQtMS1qb3JvQDhieXRlcy5vcmcvDQo+IA0KPiBUaGFua3MgZm9yIHRoZSBjb250aW51ZWQgaW1w
cm92ZW1lbnRzIGluIHRoaXMgYXJlYSENCj4gDQo+IEkgbWF5IGhhdmUgc3BvdHRlZCBhIHByb2Js
ZW0gd2l0aCBzZXR1cHMgbGlrZSBWTUQuDQo+IA0KPiBUaGUgY29yZSBQQ0kgYnVzIGlzIHNldCB1
cCBkdXJpbmcgZWFybHkgYm9vdC4NCj4gVGhlbiwgZm9yIHRoZSBQQ0kgYnVzLCB3ZSByZWFjaCBp
b21tdV9idXNfaW5pdCgpIC0+IGJ1c19pb21tdV9wcm9iZSgpLg0KPiBJbiB0aGVyZSwgd2UgY2Fs
bCBwcm9iZV9pb21tdV9ncm91cCgpIC0+IGRldl9pb21tdV9nZXQoKSBmb3IgZWFjaCBQQ0kNCj4g
ZGV2aWNlLCB3aGljaCBhbGxvY2F0ZXMgZGV2LT5pb21tdSBpbiBlYWNoIGNhc2UuIFNvIGZhciBz
byBnb29kLg0KPiANCj4gVGhlIHByb2JsZW0gaXMgdGhhdCB0aGlzIGlzIHRoZSBsYXN0IHRpbWUg
dGhhdCB3ZSdsbCBjYWxsIGRldl9pb21tdV9nZXQoKS4NCj4gSWYgYW55IFBDSSBidXMgZGV2aWNl
cyBnZXQgYWRkZWQgYWZ0ZXIgdGhpcyBwb2ludCwgdGhleSBkbyBub3QgZ2V0IHBhc3NlZA0KPiB0
byBkZXZfaW9tbXVfZ2V0KCkuDQo+IA0KPiBTbyB3aGVuIHRoZSB2bWQgbW9kdWxlIGdldHMgbG9h
ZGVkIGxhdGVyLCBhbmQgY3JlYXRlcyBtb3JlIFBDSSBkZXZpY2VzLA0KPiB3ZSBlbmQgdXAgaW4g
aW9tbXVfYnVzX25vdGlmaWVyKCkgLT4gaW9tbXVfcHJvYmVfZGV2aWNlKCkNCj4gLT4gX19pb21t
dV9wcm9iZV9kZXZpY2UoKSB3aGljaCBkb2VzOg0KPiANCj4gCWRldi0+aW9tbXUtPmlvbW11X2Rl
diA9IGlvbW11X2RldjsNCj4gDQo+IGRldi0+aW9tbXUtPiBpcyBhIE5VTEwgZGVyZWZlcmVuY2Ug
YmVjYXVzZSBkZXZfaW9tbXVfZ2V0KCkgd2FzIG5ldmVyDQo+IGNhbGxlZCBmb3IgdGhpcyBuZXcg
ZGV2aWNlLg0KPiANCj4gRGFuaWVsDQo+IA0KDQpJIHNob3VsZCBoYXZlIENDZWQgeW91IG9uIHRo
aXMsIGJ1dCBpdCBzaG91bGQgdGVtcG9yYXJpbHkgcmVzb2x2ZSB0aGF0DQppc3N1ZToNCmh0dHBz
Oi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9waXBlcm1haWwvaW9tbXUvMjAyMC1BcHJpbC8w
NDMyNTMuaHRtbA0KDQo=
