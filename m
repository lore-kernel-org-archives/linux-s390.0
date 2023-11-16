Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28FEBC197A0
	for <linux-s390@archiver.kernel.org>; Thu, 16 Nov 2023 12:06:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230385AbjKPMGd (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Thu, 16 Nov 2023 07:06:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230160AbjKPMGd (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 16 Nov 2023 07:06:33 -0500
Received: from baidu.com (mx20.baidu.com [111.202.115.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF46AB4;
        Thu, 16 Nov 2023 04:06:25 -0800 (PST)
From:   "Li,Rongqing" <lirongqing@baidu.com>
To:     Wen Gu <guwen@linux.alibaba.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
        "dust.li@linux.alibaba.com" <dust.li@linux.alibaba.com>
Subject: RE: [PATCH][net-next] net/smc: avoid atomic_set and smp_wmb in the tx
 path when possible
Thread-Topic: [PATCH][net-next] net/smc: avoid atomic_set and smp_wmb in the
 tx path when possible
Thread-Index: AQHaGG86V3lsEoc0T0O8PDgZDtb7pLB82Zzg
Date:   Thu, 16 Nov 2023 12:06:21 +0000
Message-ID: <3816364405a04427999739f5ca0b0536@baidu.com>
References: <20231116022041.51959-1-lirongqing@baidu.com>
 <d8c0ac0d-f28b-8984-06f9-41bfdcb03425@linux.alibaba.com>
In-Reply-To: <d8c0ac0d-f28b-8984-06f9-41bfdcb03425@linux.alibaba.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.22.206.6]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-FEAS-Client-IP: 172.31.51.53
X-FE-Last-Public-Client-IP: 100.100.100.38
X-FE-Policy-ID: 15:10:21:SYSTEM
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogV2VuIEd1IDxndXdlbkBs
aW51eC5hbGliYWJhLmNvbT4NCj4gU2VudDogVGh1cnNkYXksIE5vdmVtYmVyIDE2LCAyMDIzIDU6
MjggUE0NCj4gVG86IExpLFJvbmdxaW5nIDxsaXJvbmdxaW5nQGJhaWR1LmNvbT47IHdlbmppYUBs
aW51eC5pYm0uY287DQo+IG5ldGRldkB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LXMzOTBAdmdlci5r
ZXJuZWwub3JnOyBkdXN0LmxpQGxpbnV4LmFsaWJhYmEuY29tDQo+IFN1YmplY3Q6IFJlOiBbUEFU
Q0hdW25ldC1uZXh0XSBuZXQvc21jOiBhdm9pZCBhdG9taWNfc2V0IGFuZCBzbXBfd21iIGluIHRo
ZQ0KPiB0eCBwYXRoIHdoZW4gcG9zc2libGUNCj4gDQo+IA0KPiANCj4gT24gMjAyMy8xMS8xNiAx
MDoyMCwgTGkgUm9uZ1Fpbmcgd3JvdGU6DQo+ID4gdGhlcmUgaXMgcmFyZSBwb3NzaWJpbGl0eSB0
aGF0IGNvbm4tPnR4X3B1c2hpbmcgaXMgbm90IDEsIHNpbmNlDQo+ICAgIFRoZXJlDQo+ID4gdHhf
cHVzaGluZyBpcyBqdXN0IGNoZWNrZWQgd2l0aCAxLCBzbyBtb3ZlIHRoZSBzZXR0aW5nIHR4X3B1
c2hpbmcgdG8gMQ0KPiA+IGFmdGVyIGF0b21pY19kZWNfYW5kX3Rlc3QoKSByZXR1cm4gZmFsc2Us
IHRvIGF2b2lkIGF0b21pY19zZXQgYW5kDQo+ID4gc21wX3dtYiBpbiB0eCBwYXRoDQo+ICAgICAg
ICAgICAgICAgICAgICAgICAgICAuDQo+ID4NCj4gDQo+IFNvbWUgbml0czoNCj4gDQo+IDEuIEl0
IGlzIG5vcm1hbGx5IHVzaW5nIFtQQVRDSCBuZXQtbmV4dF0gcmF0aGVyIHRoYW4gW1BBVENIXVtu
ZXQtbmV4dF0NCj4gICAgIGluIHN1YmplY3QuIEFuZCBuZXcgdmVyc2lvbiBzaG91bGQgYmV0dGVy
IGJlIG1hcmtlZC4gc3VjaCBhczoNCj4gDQo+ICAgICAjIGdpdCBmb3JtYXQtcGF0Y2ggLS1zdWJq
ZWN0LXByZWZpeD0iUEFUQ0ggbmV0LW5leHQiIC12IDMNCj4gDQo+ICAgICBBbmQgQ0MgYWxsIHJl
bGV2YW50IHBlb3BsZSBsaXN0ZWQgYnk6DQo+IA0KPiAgICAgIyAuL3NjcmlwdHMvZ2V0X21haW50
YWluZXIucGwgPHlvdXIgcGF0Y2g+DQo+IA0KPiAyLiBGZXcgaW1wcm92ZW1lbnRzIGluIHRoZSBj
b21taXQgYm9keS4NCj4gDQo+IA0KDQpPaywgdGhhbmtzIA0KDQotTGkNCg0K
