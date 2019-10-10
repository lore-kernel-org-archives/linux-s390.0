Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:40592 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726037AbfJJOPH (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 10 Oct 2019 10:15:07 -0400
From: Fabien DESSENNE <fabien.dessenne@st.com>
Subject: Re: [PATCH 2/4] media: bdisp: fix memleak on release
Date: Thu, 10 Oct 2019 14:07:23 +0000
Message-ID: <5cb3040c-8c6a-ee38-be4f-b83fa9d98686@st.com>
References: <20191010131333.23635-1-johan@kernel.org>
 <20191010131333.23635-3-johan@kernel.org>
In-Reply-To: <20191010131333.23635-3-johan@kernel.org>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <09FA797EF141D1488C813B9ADD032BE3@st.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Johan Hovold <johan@kernel.org>, Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>, Mauro Carvalho Chehab <mchehab@kernel.org>, Harald Freudenberger <freude@linux.ibm.com>
Cc: David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "freedreno@lists.freedesktop.org" <freedreno@lists.freedesktop.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>, "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable <stable@vger.kernel.org>, Hans Verkuil <hans.verkuil@cisco.com>, Mauro Carvalho Chehab <mchehab@osg.samsung.com>

SGkgSm9oYW4NCg0KVGhhbmsgeW91IGZvciB0aGUgcGF0Y2gNCg0KQlINCg0KRmFiaWVuDQoNCg0K
T24gMTAvMTAvMjAxOSAzOjEzIFBNLCBKb2hhbiBIb3ZvbGQgd3JvdGU6DQo+IElmIGEgcHJvY2Vz
cyBpcyBpbnRlcnJ1cHRlZCB3aGlsZSBhY2Nlc3NpbmcgdGhlIHZpZGVvIGRldmljZSBhbmQgdGhl
DQo+IGRldmljZSBsb2NrIGlzIGNvbnRlbmRlZCwgcmVsZWFzZSgpIGNvdWxkIHJldHVybiBlYXJs
eSBhbmQgZmFpbCB0byBmcmVlDQo+IHJlbGF0ZWQgcmVzb3VyY2VzLg0KPg0KPiBOb3RlIHRoYXQg
dGhlIHJldHVybiB2YWx1ZSBvZiB0aGUgdjRsMiByZWxlYXNlIGZpbGUgb3BlcmF0aW9uIGlzDQo+
IGlnbm9yZWQuDQo+DQo+IEZpeGVzOiAyOGZmZWViYmI3YmQgKCJbbWVkaWFdIGJkaXNwOiAyRCBi
bGl0dGVyIGRyaXZlciB1c2luZyB2NGwyIG1lbTJtZW0gZnJhbWV3b3JrIikNCj4gQ2M6IHN0YWJs
ZSA8c3RhYmxlQHZnZXIua2VybmVsLm9yZz4gICAgICMgNC4yDQo+IENjOiBGYWJpZW4gRGVzc2Vu
bmUgPGZhYmllbi5kZXNzZW5uZUBzdC5jb20+DQo+IENjOiBIYW5zIFZlcmt1aWwgPGhhbnMudmVy
a3VpbEBjaXNjby5jb20+DQo+IENjOiBNYXVybyBDYXJ2YWxobyBDaGVoYWIgPG1jaGVoYWJAb3Nn
LnNhbXN1bmcuY29tPg0KPiBTaWduZWQtb2ZmLWJ5OiBKb2hhbiBIb3ZvbGQgPGpvaGFuQGtlcm5l
bC5vcmc+DQpSZXZpZXdlZC1ieTogRmFiaWVuIERlc3Nlbm5lIDxmYWJpZW4uZGVzc2VubmVAc3Qu
Y29tPg0KPiAtLS0NCj4gICBkcml2ZXJzL21lZGlhL3BsYXRmb3JtL3N0aS9iZGlzcC9iZGlzcC12
NGwyLmMgfCAzICstLQ0KPiAgIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMiBkZWxl
dGlvbnMoLSkNCj4NCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbWVkaWEvcGxhdGZvcm0vc3RpL2Jk
aXNwL2JkaXNwLXY0bDIuYyBiL2RyaXZlcnMvbWVkaWEvcGxhdGZvcm0vc3RpL2JkaXNwL2JkaXNw
LXY0bDIuYw0KPiBpbmRleCBlOTBmMWJhMzA1NzQuLjY3NWI1ZjJiNGMyZSAxMDA2NDQNCj4gLS0t
IGEvZHJpdmVycy9tZWRpYS9wbGF0Zm9ybS9zdGkvYmRpc3AvYmRpc3AtdjRsMi5jDQo+ICsrKyBi
L2RyaXZlcnMvbWVkaWEvcGxhdGZvcm0vc3RpL2JkaXNwL2JkaXNwLXY0bDIuYw0KPiBAQCAtNjUx
LDggKzY1MSw3IEBAIHN0YXRpYyBpbnQgYmRpc3BfcmVsZWFzZShzdHJ1Y3QgZmlsZSAqZmlsZSkN
Cj4gICANCj4gICAJZGV2X2RiZyhiZGlzcC0+ZGV2LCAiJXNcbiIsIF9fZnVuY19fKTsNCj4gICAN
Cj4gLQlpZiAobXV0ZXhfbG9ja19pbnRlcnJ1cHRpYmxlKCZiZGlzcC0+bG9jaykpDQo+IC0JCXJl
dHVybiAtRVJFU1RBUlRTWVM7DQo+ICsJbXV0ZXhfbG9jaygmYmRpc3AtPmxvY2spOw0KPiAgIA0K
PiAgIAl2NGwyX20ybV9jdHhfcmVsZWFzZShjdHgtPmZoLm0ybV9jdHgpOw0KPiAgIA==
