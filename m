Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mail-eopbgr710089.outbound.protection.outlook.com ([40.107.71.89]:58430
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730172AbfGON2W (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Mon, 15 Jul 2019 09:28:22 -0400
From: "Lendacky, Thomas" <Thomas.Lendacky@amd.com>
Subject: Re: [PATCH 1/1] s390/protvirt: restore force_dma_unencrypted()
Date: Mon, 15 Jul 2019 13:28:19 +0000
Message-ID: <7e393b48-4165-e1d4-0450-e52dd914a3cd@amd.com>
References: <20190715131719.100650-1-pasic@linux.ibm.com>
 <20190715132027.GA18357@infradead.org>
In-Reply-To: <20190715132027.GA18357@infradead.org>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <BD6BC4716FFCF1428F04F1E63D721AB7@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Christoph Hellwig <hch@infradead.org>, Halil Pasic <pasic@linux.ibm.com>
Cc: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>, Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Thiago Jung Bauermann <bauerman@linux.ibm.com>, Thomas Gleixner <tglx@linutronix.de>, Christian Borntraeger <borntraeger@de.ibm.com>, Janosch Frank <frankja@linux.ibm.com>

T24gNy8xNS8xOSA4OjIwIEFNLCBDaHJpc3RvcGggSGVsbHdpZyB3cm90ZToNCj4gVGhpcyBsb29r
cyBnb29kIHRvIG1lIC0gaWYgeW91IGFuZCBUb20gYXJlIGZpbmUgd2l0aCBpdCBJJ2QgbGlrZSB0
bw0KPiBmb2xkIGl0IGludG8gaGlzIGNvbW1pdCBzbyB0aGF0IHdoYXQgSSdsbCBzZW5kIHRvIExp
bnVzIGlzIGJpc2VjdGlvbg0KPiBjbGVhbi4NCg0KSSdtIG9rIHdpdGggZm9sZGluZyBpdCBpbi4g
U29ycnkgYWJvdXQgbWlzc2luZyB0aGF0Lg0KDQpUaGFua3MsDQpUb20NCg0KPiANCj4+IE5vdGU6
IHdlIHN0aWxsIG5lZWQgc2V2X2FjdGl2ZSgpIGRlZmluZWQgYmVjYXVzZSBvZiB0aGUgcmVmZXJl
bmNlDQo+PiBpbiBmcy9jb3JlL3ZtY29yZSwgYnV0IHRoaXMgb25lIGlzIGxpa2VseSB0byBnbyBh
d2F5IHNvb24gYWxvbmcNCj4+IHdpdGggdGhlIG5lZWQgZm9yIGFuIHMzOTAgc2V2X2FjdGl2ZSgp
Lg0KPiANCj4gQW55IGNoYW5jZSB3ZSBjb3VsZCBub3QgY2hhbmdlIHRoZSByZXR1cm4gdmFsdWUg
ZnJvbSB0aGUgZnVuY3Rpb24NCj4gYXQgbGVhc3QgaW4gdGhpcyBwYXRjaC9mb2xkIGFzIHRoYXQg
Y2hhbmdlIHNlZW1zIHVucmVsYXRlZCB0byB0aGUNCj4gZG1hIGZ1bmN0aW9uYWxpdHkuICBJZiB0
aGF0IGlzIHdoYXQgeW91IHJlYWxseSB3YW50ZWQgYW5kIG9ubHkNCj4gdGhlIGRtYSBjb2RlIHdh
cyBpbiB0aGUgd2F5IHdlIGNhbiBoYXBwaWx5IG1lcmdlIGl0IGFzIGEgc2VwYXJhdGUNCj4gcGF0
Y2gsIG9mIGNvdXNlLg0KPiANCg==
