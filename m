Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from szxga08-in.huawei.com ([45.249.212.255]:2823 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234551AbhBDJFi (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 4 Feb 2021 04:05:38 -0500
From: zhengyongjun <zhengyongjun3@huawei.com>
Subject: =?utf-8?B?562U5aSNOiBbUEFUQ0ggLW5leHRdIEtWTTogczM5MDogUmV0dXJuIHRoZSBj?=
 =?utf-8?Q?orrect_errno_code?=
Date: Thu, 4 Feb 2021 09:04:53 +0000
Message-ID: <e6926214bd4048ec93f9ad13f83205d3@huawei.com>
References: <20210204080523.18943-1-zhengyongjun3@huawei.com>
 <20210204093227.3f088c8a.cohuck@redhat.com>
 <267785c5-527d-3294-cc7e-670d49d87082@de.ibm.com>
In-Reply-To: <267785c5-527d-3294-cc7e-670d49d87082@de.ibm.com>
Content-Language: zh-CN
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
List-ID: <linux-s390.vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>
Cc: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "frankja@linux.ibm.com" <frankja@linux.ibm.com>, "david@redhat.com" <david@redhat.com>, "imbrenda@linux.ibm.com" <imbrenda@linux.ibm.com>, "hca@linux.ibm.com" <hca@linux.ibm.com>, "gor@linux.ibm.com" <gor@linux.ibm.com>

VGhhbmtzIGZvciB5b3VyIGFkdmljZSwgSSB3aWxsIGRvIHRoaXMgYmV0dGVyIGxhdGVyIDopDQoN
Ci0tLS0t6YKu5Lu25Y6f5Lu2LS0tLS0NCuWPkeS7tuS6ujogQ2hyaXN0aWFuIEJvcm50cmFlZ2Vy
IFttYWlsdG86Ym9ybnRyYWVnZXJAZGUuaWJtLmNvbV0gDQrlj5HpgIHml7bpl7Q6IDIwMjHlubQy
5pyINOaXpSAxNjo0Mg0K5pS25Lu25Lq6OiBDb3JuZWxpYSBIdWNrIDxjb2h1Y2tAcmVkaGF0LmNv
bT47IHpoZW5neW9uZ2p1biA8emhlbmd5b25nanVuM0BodWF3ZWkuY29tPg0K5oqE6YCBOiBrdm1A
dmdlci5rZXJuZWwub3JnOyBsaW51eC1zMzkwQHZnZXIua2VybmVsLm9yZzsgbGludXgta2VybmVs
QHZnZXIua2VybmVsLm9yZzsgZnJhbmtqYUBsaW51eC5pYm0uY29tOyBkYXZpZEByZWRoYXQuY29t
OyBpbWJyZW5kYUBsaW51eC5pYm0uY29tOyBoY2FAbGludXguaWJtLmNvbTsgZ29yQGxpbnV4Lmli
bS5jb20NCuS4u+mimDogUmU6IFtQQVRDSCAtbmV4dF0gS1ZNOiBzMzkwOiBSZXR1cm4gdGhlIGNv
cnJlY3QgZXJybm8gY29kZQ0KDQpPbiAwNC4wMi4yMSAwOTozMiwgQ29ybmVsaWEgSHVjayB3cm90
ZToNCj4gT24gVGh1LCA0IEZlYiAyMDIxIDE2OjA1OjIzICswODAwDQo+IFpoZW5nIFlvbmdqdW4g
PHpoZW5neW9uZ2p1bjNAaHVhd2VpLmNvbT4gd3JvdGU6DQo+IA0KPj4gV2hlbiB2YWxsb2MgZmFp
bGVkLCBzaG91bGQgcmV0dXJuIEVOT01FTSByYXRoZXIgdGhhbiBFTk9CVUYuDQo+Pg0KPj4gU2ln
bmVkLW9mZi1ieTogWmhlbmcgWW9uZ2p1biA8emhlbmd5b25nanVuM0BodWF3ZWkuY29tPg0KPj4g
LS0tDQo+PiAgYXJjaC9zMzkwL2t2bS9pbnRlcnJ1cHQuYyB8IDIgKy0NCj4+ICAxIGZpbGUgY2hh
bmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkNCj4+DQo+PiBkaWZmIC0tZ2l0IGEv
YXJjaC9zMzkwL2t2bS9pbnRlcnJ1cHQuYyBiL2FyY2gvczM5MC9rdm0vaW50ZXJydXB0LmMgDQo+
PiBpbmRleCAyZjE3NzI5OGM2NjMuLjZiN2FjYzI3Y2ZhMiAxMDA2NDQNCj4+IC0tLSBhL2FyY2gv
czM5MC9rdm0vaW50ZXJydXB0LmMNCj4+ICsrKyBiL2FyY2gvczM5MC9rdm0vaW50ZXJydXB0LmMN
Cj4+IEBAIC0yMjUyLDcgKzIyNTIsNyBAQCBzdGF0aWMgaW50IGdldF9hbGxfZmxvYXRpbmdfaXJx
cyhzdHJ1Y3Qga3ZtICprdm0sIHU4IF9fdXNlciAqdXNyYnVmLCB1NjQgbGVuKQ0KPj4gIAkgKi8N
Cj4+ICAJYnVmID0gdnphbGxvYyhsZW4pOw0KPj4gIAlpZiAoIWJ1ZikNCj4+IC0JCXJldHVybiAt
RU5PQlVGUzsNCj4+ICsJCXJldHVybiAtRU5PTUVNOw0KPj4gIA0KPj4gIAltYXhfaXJxcyA9IGxl
biAvIHNpemVvZihzdHJ1Y3Qga3ZtX3MzOTBfaXJxKTsNCj4+ICANCj4gDQo+IFRoaXMgYnJlYWtz
IGEgdXNlciBzcGFjZSBpbnRlcmZhY2UgKHNlZSB0aGUgY29tbWVudCByaWdodCBhYm92ZSB0aGUg
DQo+IHZ6YWxsb2MpLg0KDQoNClJpZ2h0LiBQbGVhc2UgZG8gbm90IHNlbmQgKGdlbmVyYXRlZD8p
IHBhdGNoZXMgd2l0aG91dCBsb29raW5nIGF0IHRoZSBjb2RlIHRoYXQgeW91IGFyZSBwYXRjaGlu
Zy4NCg==
