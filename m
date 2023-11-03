Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2C24C4332F
	for <linux-s390@archiver.kernel.org>; Fri,  3 Nov 2023 05:11:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229527AbjKCFLb (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Fri, 3 Nov 2023 01:11:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjKCFLb (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 3 Nov 2023 01:11:31 -0400
Received: from baidu.com (mx20.baidu.com [111.202.115.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81F0C1A7;
        Thu,  2 Nov 2023 22:11:26 -0700 (PDT)
From:   "Li,Rongqing" <lirongqing@baidu.com>
To:     Wenjia Zhang <wenjia@linux.ibm.com>
CC:     "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: RE: [PATCH] net/smc: avoid atomic_set and smp_wmb in the tx path when
 possible
Thread-Topic: [PATCH] net/smc: avoid atomic_set and smp_wmb in the tx path
 when possible
Thread-Index: AQHaDc0XDjwnGoCXVUiRNSdWa8EgxrBoBRFg
Date:   Fri, 3 Nov 2023 04:56:00 +0000
Message-ID: <3a5eedd0376b4a29b351a1f43b81c384@baidu.com>
References: <20231102092712.30793-1-lirongqing@baidu.com>
 <4b1c9303-9ad1-42f3-a1a2-b9ccfcafd022@linux.ibm.com>
In-Reply-To: <4b1c9303-9ad1-42f3-a1a2-b9ccfcafd022@linux.ibm.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.22.206.15]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-FEAS-Client-IP: 10.127.64.36
X-FE-Last-Public-Client-IP: 100.100.100.38
X-FE-Policy-ID: 15:10:21:SYSTEM
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogV2VuamlhIFpoYW5nIDx3
ZW5qaWFAbGludXguaWJtLmNvbT4NCj4gU2VudDogRnJpZGF5LCBOb3ZlbWJlciAzLCAyMDIzIDQ6
NDIgQU0NCj4gVG86IExpLFJvbmdxaW5nIDxsaXJvbmdxaW5nQGJhaWR1LmNvbT4NCj4gQ2M6IGxp
bnV4LXMzOTBAdmdlci5rZXJuZWwub3JnOyBuZXRkZXZAdmdlci5rZXJuZWwub3JnDQo+IFN1Ympl
Y3Q6IFJlOiBbUEFUQ0hdIG5ldC9zbWM6IGF2b2lkIGF0b21pY19zZXQgYW5kIHNtcF93bWIgaW4g
dGhlIHR4IHBhdGgNCj4gd2hlbiBwb3NzaWJsZQ0KPiANCj4gDQo+IA0KPiBPbiAwMi4xMS4yMyAx
MDoyNywgTGkgUm9uZ1Fpbmcgd3JvdGU6DQo+ID4gdGhlc2UgaXMgbGVzcyBvcHBvcnR1bml0eSB0
aGF0IGNvbm4tPnR4X3B1c2hpbmcgaXMgbm90IDEsIHNpbmNlDQo+ID4gdHhfcHVzaGluZyBpcyBq
dXN0IGNoZWNrZWQgd2l0aCAxLCBzbyBtb3ZlIHRoZSBzZXR0aW5nIHR4X3B1c2hpbmcgdG8gMQ0K
PiA+IGFmdGVyIGF0b21pY19kZWNfYW5kX3Rlc3QoKSByZXR1cm4gZmFsc2UsIHRvIGF2b2lkIGF0
b21pY19zZXQgYW5kDQo+ID4gc21wX3dtYiBpbiB0eCBwYXRoIHdoZW4gcG9zc2libGUNCj4gPg0K
PiBJIHRoaW5rIHdlIHNob3VsZCBhdm9pZCB0byB1c2UgYXJndW1lbnQgbGlrZSAibGVzcyBvcHBv
cnR1bml0eSIgaW4gY29tbWl0DQo+IG1lc3NhZ2UuIEJlY2F1c2UgImxlc3Mgb3Bwb3J0dW5pdHki
IGRvZXMgbm90IG1lYW4gIm5vIG9wcG9ydHVuaXR5Ii4gT25jZSBpdA0KPiBvY2N1cnMsIGRvZXMg
aXQgbWVhbiB0aGF0IHdoYXQgdGhlIHBhdGNoIGNoYW5nZXMgaXMgdXNlbGVzcyBvciB3cm9uZz8N
Cj4gDQoNCkkgd2lsbCByZXdvcmQgdGhlIG1lc3NhZ2UuDQpJIHRoaW5rIHRoaXMgaXMgYSBxdWVz
dGlvbiBvZiBwcm9iYWJpbGl0eS4gZXZlbiB0eF9wdXNoaW5nIGlzIG5vdCAxLCB0aGlzIGlzIHN0
aWxsIG5vdCBhIHByb2JsZW0sIGF0b21pY19kZWNfYW5kX3Rlc3QoJmNvbm4tPnR4X3B1c2hpbmcp
IHdpbGwgcmV0dXJuIGZhbHNlLCB0cmFuc21pdCB3aWxsIGJlIGxvb3BlZCBhZ2FpbiwgYW5kIHR4
X3B1c2hpbmcgd2lsbCBiZSBhZGRlZCBhdCBhbnkgdGltZQ0KDQo+ID4gU2lnbmVkLW9mZi1ieTog
TGkgUm9uZ1FpbmcgPGxpcm9uZ3FpbmdAYmFpZHUuY29tPg0KPiA+IC0tLQ0KPiA+ICAgbmV0L3Nt
Yy9zbWNfdHguYyB8IDcgKysrKy0tLQ0KPiA+ICAgMSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9u
cygrKSwgMyBkZWxldGlvbnMoLSkNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9uZXQvc21jL3NtY190
eC5jIGIvbmV0L3NtYy9zbWNfdHguYyBpbmRleA0KPiA+IDNiMGZmM2IuLjcyZGJkZWUgMTAwNjQ0
DQo+ID4gLS0tIGEvbmV0L3NtYy9zbWNfdHguYw0KPiA+ICsrKyBiL25ldC9zbWMvc21jX3R4LmMN
Cj4gPiBAQCAtNjY3LDggKzY2Nyw2IEBAIGludCBzbWNfdHhfc25kYnVmX25vbmVtcHR5KHN0cnVj
dCBzbWNfY29ubmVjdGlvbg0KPiAqY29ubikNCj4gPiAgIAkJcmV0dXJuIDA7DQo+ID4NCj4gPiAg
IGFnYWluOg0KPiA+IC0JYXRvbWljX3NldCgmY29ubi0+dHhfcHVzaGluZywgMSk7DQo+ID4gLQlz
bXBfd21iKCk7IC8qIE1ha2Ugc3VyZSB0eF9wdXNoaW5nIGlzIDEgYmVmb3JlIHJlYWwgc2VuZCAq
Lw0KPiA+ICAgCXJjID0gX19zbWNfdHhfc25kYnVmX25vbmVtcHR5KGNvbm4pOw0KPiA+DQo+ID4g
ICAJLyogV2UgbmVlZCB0byBjaGVjayB3aGV0aGVyIHNvbWVvbmUgZWxzZSBoYXZlIGFkZGVkIHNv
bWUgZGF0YQ0KPiBpbnRvDQo+ID4gQEAgLTY3Nyw4ICs2NzUsMTEgQEAgaW50IHNtY190eF9zbmRi
dWZfbm9uZW1wdHkoc3RydWN0DQo+IHNtY19jb25uZWN0aW9uICpjb25uKQ0KPiA+ICAgCSAqIElm
IHNvLCB3ZSBuZWVkIHRvIHB1c2ggYWdhaW4gdG8gcHJldmVudCB0aG9zZSBkYXRhIGhhbmcgaW4g
dGhlIHNlbmQNCj4gPiAgIAkgKiBxdWV1ZS4NCj4gPiAgIAkgKi8NCj4gPiAtCWlmICh1bmxpa2Vs
eSghYXRvbWljX2RlY19hbmRfdGVzdCgmY29ubi0+dHhfcHVzaGluZykpKQ0KPiA+ICsJaWYgKHVu
bGlrZWx5KCFhdG9taWNfZGVjX2FuZF90ZXN0KCZjb25uLT50eF9wdXNoaW5nKSkpIHsNCj4gPiAr
CQlhdG9taWNfc2V0KCZjb25uLT50eF9wdXNoaW5nLCAxKTsNCj4gPiArCQlzbXBfd21iKCk7IC8q
IE1ha2Ugc3VyZSB0eF9wdXNoaW5nIGlzIDEgYmVmb3JlIHJlYWwgc2VuZCAqLw0KPiA+ICAgCQln
b3RvIGFnYWluOw0KPiA+ICsJfQ0KPiA+DQo+ID4gICAJcmV0dXJuIHJjOw0KPiA+ICAgfQ0KPiBJ
J20gYWZyYWlkIHRoYXQgdGhlICppZiogc3RhdGVtZW50IHdvdWxkIG5ldmVyIGJlIHRydWUsIHdp
dGhvdXQgc2V0dGluZyB0aGUNCj4gdmFsdWUgb2YgJmNvbm4tPnR4X3B1c2hpbmcgZmlyc3RseS4N
Cg0KSSB0aGluayBjb25uLT50eF9wdXNoaW5nIGRvIG5vdCBuZWVkIHRvIGJlIHNldCBpbiB0aGlz
IGNvbmRpdGlvbiwgYW5kIHRoaXMgcGF0Y2ggaXMgdHJ5aW5nIHRvIGF2b2lkIHNldHRpbmcgaXQg
DQoNClRoYW5rcw0KDQotTGkNCg0K
