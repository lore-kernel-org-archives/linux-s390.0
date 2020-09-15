Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from nat-hk.nvidia.com ([203.18.50.4]:8353 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726031AbgIOHUU (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Tue, 15 Sep 2020 03:20:20 -0400
From: Nikolay Aleksandrov <nikolay@nvidia.com>
Subject: Re: [PATCH net-next 5/8] bridge: Add SWITCHDEV_FDB_FLUSH_TO_BRIDGE
 notifier
Date: Tue, 15 Sep 2020 07:20:14 +0000
Message-ID: <ea877ec26ab6d552b8e54966446a7cf4d8698d86.camel@nvidia.com>
References: <20200910172351.5622-1-jwi@linux.ibm.com>
         <20200910172351.5622-6-jwi@linux.ibm.com>
In-Reply-To: <20200910172351.5622-6-jwi@linux.ibm.com>
Reply-To: Nikolay Aleksandrov <nikolay@nvidia.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <375E128B5005FD4D9799D1A89194BE06@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: "davem@davemloft.net" <davem@davemloft.net>, "jwi@linux.ibm.com" <jwi@linux.ibm.com>, "kuba@kernel.org" <kuba@kernel.org>
Cc: "kgraul@linux.ibm.com" <kgraul@linux.ibm.com>, "hca@linux.ibm.com" <hca@linux.ibm.com>, "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>, "wintera@linux.ibm.com" <wintera@linux.ibm.com>, "ubraun@linux.ibm.com" <ubraun@linux.ibm.com>, "jiri@resnulli.us" <jiri@resnulli.us>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, Roopa Prabhu <roopa@nvidia.com>, "ivecera@redhat.com" <ivecera@redhat.com>

T24gVGh1LCAyMDIwLTA5LTEwIGF0IDE5OjIzICswMjAwLCBKdWxpYW4gV2llZG1hbm4gd3JvdGU6
DQo+IEZyb206IEFsZXhhbmRyYSBXaW50ZXIgPHdpbnRlcmFAbGludXguaWJtLmNvbT4NCj4gDQo+
IHNvIHRoZSBzd2l0Y2hkZXYgY2FuIG5vdGlmaXkgdGhlIGJyaWRnZSB0byBmbHVzaCBub24tcGVy
bWFuZW50IGZkYiBlbnRyaWVzDQo+IGZvciB0aGlzIHBvcnQuIFRoaXMgaXMgdXNlZnVsIHdoZW5l
dmVyIHRoZSBoYXJkd2FyZSBmZGIgb2YgdGhlIHN3aXRjaGRldg0KPiBpcyByZXNldCwgYnV0IHRo
ZSBuZXRkZXYgYW5kIHRoZSBicmlkZ2Vwb3J0IGFyZSBub3QgZGVsZXRlZC4NCj4gDQo+IE5vdGUg
dGhhdCB0aGlzIGhhcyB0aGUgc2FtZSBlZmZlY3QgYXMgdGhlIElGTEFfQlJQT1JUX0ZMVVNIIGF0
dHJpYnV0ZS4NCj4gDQo+IENDOiBKaXJpIFBpcmtvIDxqaXJpQHJlc251bGxpLnVzPg0KPiBDQzog
SXZhbiBWZWNlcmEgPGl2ZWNlcmFAcmVkaGF0LmNvbT4NCj4gQ0M6IFJvb3BhIFByYWJodSA8cm9v
cGFAbnZpZGlhLmNvbT4NCj4gQ0M6IE5pa29sYXkgQWxla3NhbmRyb3YgPG5pa29sYXlAbnZpZGlh
LmNvbT4NCj4gU2lnbmVkLW9mZi1ieTogQWxleGFuZHJhIFdpbnRlciA8d2ludGVyYUBsaW51eC5p
Ym0uY29tPg0KPiBTaWduZWQtb2ZmLWJ5OiBKdWxpYW4gV2llZG1hbm4gPGp3aUBsaW51eC5pYm0u
Y29tPg0KPiAtLS0NCj4gIGluY2x1ZGUvbmV0L3N3aXRjaGRldi5oIHwgMSArDQo+ICBuZXQvYnJp
ZGdlL2JyLmMgICAgICAgICB8IDUgKysrKysNCj4gIDIgZmlsZXMgY2hhbmdlZCwgNiBpbnNlcnRp
b25zKCspDQo+IA0KPiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9uZXQvc3dpdGNoZGV2LmggYi9pbmNs
dWRlL25ldC9zd2l0Y2hkZXYuaA0KPiBpbmRleCBmZjIyNDY5MTQzMDEuLjUzZThiNDk5NDI5NiAx
MDA2NDQNCj4gLS0tIGEvaW5jbHVkZS9uZXQvc3dpdGNoZGV2LmgNCj4gKysrIGIvaW5jbHVkZS9u
ZXQvc3dpdGNoZGV2LmgNCj4gQEAgLTIwMyw2ICsyMDMsNyBAQCBlbnVtIHN3aXRjaGRldl9ub3Rp
Zmllcl90eXBlIHsNCj4gIAlTV0lUQ0hERVZfRkRCX0FERF9UT19ERVZJQ0UsDQo+ICAJU1dJVENI
REVWX0ZEQl9ERUxfVE9fREVWSUNFLA0KPiAgCVNXSVRDSERFVl9GREJfT0ZGTE9BREVELA0KPiAr
CVNXSVRDSERFVl9GREJfRkxVU0hfVE9fQlJJREdFLA0KPiAgDQo+ICAJU1dJVENIREVWX1BPUlRf
T0JKX0FERCwgLyogQmxvY2tpbmcuICovDQo+ICAJU1dJVENIREVWX1BPUlRfT0JKX0RFTCwgLyog
QmxvY2tpbmcuICovDQo+IGRpZmYgLS1naXQgYS9uZXQvYnJpZGdlL2JyLmMgYi9uZXQvYnJpZGdl
L2JyLmMNCj4gaW5kZXggYjZmZTMwZTM3NjhmLi40MDFlZWI5MTQyZWIgMTAwNjQ0DQo+IC0tLSBh
L25ldC9icmlkZ2UvYnIuYw0KPiArKysgYi9uZXQvYnJpZGdlL2JyLmMNCj4gQEAgLTE4Myw2ICsx
ODMsMTEgQEAgc3RhdGljIGludCBicl9zd2l0Y2hkZXZfZXZlbnQoc3RydWN0IG5vdGlmaWVyX2Js
b2NrICp1bnVzZWQsDQo+ICAJCWJyX2ZkYl9vZmZsb2FkZWRfc2V0KGJyLCBwLCBmZGJfaW5mby0+
YWRkciwNCj4gIAkJCQkgICAgIGZkYl9pbmZvLT52aWQsIGZkYl9pbmZvLT5vZmZsb2FkZWQpOw0K
PiAgCQlicmVhazsNCj4gKwljYXNlIFNXSVRDSERFVl9GREJfRkxVU0hfVE9fQlJJREdFOg0KPiAr
CQlmZGJfaW5mbyA9IHB0cjsNCj4gKwkJLyogRG9uJ3QgZGVsZXRlIHN0YXRpYyBlbnRyaWVzICov
DQo+ICsJCWJyX2ZkYl9kZWxldGVfYnlfcG9ydChiciwgcCwgZmRiX2luZm8tPnZpZCwgMCk7DQo+
ICsJCWJyZWFrOw0KPiAgCX0NCj4gIA0KPiAgb3V0Og0KDQpBY2tlZC1ieTogTmlrb2xheSBBbGVr
c2FuZHJvdiA8bmlrb2xheUBudmlkaWEuY29tPg0K
