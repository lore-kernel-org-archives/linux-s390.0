Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.31]:28746 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727871AbgDMWKv (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Mon, 13 Apr 2020 18:10:51 -0400
From: "Derrick, Jonathan" <jonathan.derrick@intel.com>
Subject: Re: [RFC PATCH 11/34] iommu: Split off default domain allocation
 from group assignment
Date: Mon, 13 Apr 2020 22:10:50 +0000
Message-ID: <6a801ff9e6471bda7c6f510dfa2ba7e7c35cb559.camel@intel.com>
References: <20200407183742.4344-1-joro@8bytes.org>
         <20200407183742.4344-12-joro@8bytes.org>
In-Reply-To: <20200407183742.4344-12-joro@8bytes.org>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <32CCA6BEC8F53949916D97ED0C44AA2D@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: "heiko@sntech.de" <heiko@sntech.de>, "kgene@kernel.org" <kgene@kernel.org>, "jonathanh@nvidia.com" <jonathanh@nvidia.com>, "robin.murphy@arm.com" <robin.murphy@arm.com>, "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>, "thierry.reding@gmail.com" <thierry.reding@gmail.com>, "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>, "dwmw2@infradead.org" <dwmw2@infradead.org>, "m.szyprowski@samsung.com" <m.szyprowski@samsung.com>, "joro@8bytes.org" <joro@8bytes.org>, "will@kernel.org" <will@kernel.org>, "jean-philippe@linaro.org" <jean-philippe@linaro.org>, "krzk@kernel.org" <krzk@kernel.org>, "robdclark@gmail.com" <robdclark@gmail.com>, "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>, "gerald.schaefer@de.ibm.com" <gerald.schaefer@de.ibm.com>, "agross@kernel.org" <agross@kernel.org>
Cc: "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "linux-rockchip@lists.infradead.org" <linux-rockchip@lists.infradead.org>, "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>, "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>, "jroedel@suse.de" <jroedel@suse.de>

SGkgSm9lcmcsDQoNCk9uIFR1ZSwgMjAyMC0wNC0wNyBhdCAyMDozNyArMDIwMCwgSm9lcmcgUm9l
ZGVsIHdyb3RlOg0KPiBGcm9tOiBKb2VyZyBSb2VkZWwgPGpyb2VkZWxAc3VzZS5kZT4NCj4gDQo+
IFdoZW4gYSBidXMgaXMgaW5pdGlhbGl6ZWQgd2l0aCBpb21tdS1vcHMsIGFsbCBkZXZpY2VzIG9u
IHRoZSBidXMgYXJlDQo+IHNjYW5uZWQgYW5kIGlvbW11LWdyb3VwcyBhcmUgYWxsb2NhdGVkIGZv
ciB0aGVtLCBhbmQgZWFjaCBncm91cHMgd2lsbA0KPiBhbHNvIGdldCBhIGRlZmF1bHQgZG9tYWlu
IGFsbG9jYXRlZC4NCj4gDQo+IFVudGlsIG5vdyB0aGlzIGhhcHBlbmVkIGFzIHNvb24gYXMgdGhl
IGdyb3VwIHdhcyBjcmVhdGVkIGFuZCB0aGUgZmlyc3QNCj4gZGV2aWNlIGFkZGVkIHRvIGl0LiBX
aGVuIG90aGVyIGRldmljZXMgd2l0aCBkaWZmZXJlbnQgZGVmYXVsdCBkb21haW4NCj4gcmVxdWly
ZW1lbnRzIHdlcmUgYWRkZWQgdG8gdGhlIGdyb3VwIGxhdGVyIG9uLCB0aGUgZGVmYXVsdCBkb21h
aW4gd2FzDQo+IHJlLWFsbG9jYXRlZCwgaWYgcG9zc2libGUuDQo+IA0KPiBUaGlzIHJlc3VsdGVk
IGluIHNvbWUgYmFjayBhbmQgZm9ydGggYW5kIHVubmVjZXNzYXJ5IGFsbG9jYXRpb25zLCBzbw0K
PiBjaGFuZ2UgdGhlIGZsb3cgdG8gZGVmZXIgZGVmYXVsdCBkb21haW4gYWxsb2NhdGlvbiB1bnRp
bCBhbGwgZGV2aWNlcw0KPiBoYXZlIGJlZW4gYWRkZWQgdG8gdGhlaXIgcmVzcGVjdGl2ZSBJT01N
VSBncm91cHMuDQo+IA0KPiBUaGUgZGVmYXVsdCBkb21haW5zIGFyZSBhbGxvY2F0ZWQgZm9yIG5l
d2x5IGFsbG9jYXRlZCBncm91cHMgYWZ0ZXINCj4gZWFjaCBkZXZpY2Ugb24gdGhlIGJ1cyBpcyBo
YW5kbGVkIGFuZCB3YXMgcHJvYmVkIGJ5IHRoZSBJT01NVSBkcml2ZXIuDQo+IA0KPiBTaWduZWQt
b2ZmLWJ5OiBKb2VyZyBSb2VkZWwgPGpyb2VkZWxAc3VzZS5kZT4NCj4gLS0tDQpbc25pcF0NCg0K
DQpJIGhhZCB0byBhZGQgdGhlIGZvbGxvd2luZyBmb3IgaW5pdGlhbCBWTUQgc3VwcG9ydC4gVGhl
IG5ldyBQQ0llIGRvbWFpbg0KYWRkZWQgb24gVk1EIGVuZHBvaW50IHByb2JlIGRpZG4ndCBoYXZl
IHRoZSBkZXZfaW9tbXUgbWVtYmVyIHNldCBvbiB0aGUNClZNRCBzdWJkZXZpY2VzLCB3aGljaCBJ
J20gZ3Vlc3NpbmcgaXMgZHVlIHRvIHByb2JlX2lvbW11X2dyb3VwIGFscmVhZHkNCmhhdmluZyBi
ZWVuIHJ1biBvbiB0aGUgVk1EIGVuZHBvaW50J3MgZ3JvdXAgcHJpb3IgdG8gdGhvc2Ugc3ViZGV2
aWNlcw0KYmVpbmcgYWRkZWQuDQoNCmRpZmYgLS1naXQgYS9kcml2ZXJzL2lvbW11L2lvbW11LmMg
Yi9kcml2ZXJzL2lvbW11L2lvbW11LmMNCmluZGV4IDhhNWUxYWMzMjhkZC4uYWMxZTRmYjliZjQ4
IDEwMDY0NA0KLS0tIGEvZHJpdmVycy9pb21tdS9pb21tdS5jDQorKysgYi9kcml2ZXJzL2lvbW11
L2lvbW11LmMNCkBAIC0xNTc3LDYgKzE1NzcsOSBAQCBzdGF0aWMgaW50IGlvbW11X2J1c19ub3Rp
ZmllcihzdHJ1Y3Qgbm90aWZpZXJfYmxvY2sgKm5iLA0KICAgICAgICBpZiAoYWN0aW9uID09IEJV
U19OT1RJRllfQUREX0RFVklDRSkgew0KICAgICAgICAgICAgICAgIGludCByZXQ7DQogDQorICAg
ICAgICAgICAgICAgaWYgKCFkZXZfaW9tbXVfZ2V0KGRldikpDQorICAgICAgICAgICAgICAgICAg
ICAgICByZXR1cm4gLUVOT01FTTsNCisNCiAgICAgICAgICAgICAgICByZXQgPSBpb21tdV9wcm9i
ZV9kZXZpY2UoZGV2KTsNCiAgICAgICAgICAgICAgICByZXR1cm4gKHJldCkgPyBOT1RJRllfRE9O
RSA6IE5PVElGWV9PSzsNCiAgICAgICAgfSBlbHNlIGlmIChhY3Rpb24gPT0gQlVTX05PVElGWV9S
RU1PVkVEX0RFVklDRSkgew0K
