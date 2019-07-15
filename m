Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mail-eopbgr810053.outbound.protection.outlook.com ([40.107.81.53]:56768
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730650AbfGOPZs (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Mon, 15 Jul 2019 11:25:48 -0400
From: "Lendacky, Thomas" <Thomas.Lendacky@amd.com>
Subject: Re: [PATCH 1/1] s390/protvirt: restore force_dma_unencrypted()
Date: Mon, 15 Jul 2019 15:25:45 +0000
Message-ID: <3f6616a5-7fd5-c706-4d2b-90341882e602@amd.com>
References: <20190715131719.100650-1-pasic@linux.ibm.com>
 <20190715132027.GA18357@infradead.org>
 <7e393b48-4165-e1d4-0450-e52dd914a3cd@amd.com>
 <20190715142045.GA908@infradead.org>
In-Reply-To: <20190715142045.GA908@infradead.org>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <C0B0E7303168684AABB6319B9CC87D6B@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: Halil Pasic <pasic@linux.ibm.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>, Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Thiago Jung Bauermann <bauerman@linux.ibm.com>, Thomas Gleixner <tglx@linutronix.de>, Christian Borntraeger <borntraeger@de.ibm.com>, Janosch Frank <frankja@linux.ibm.com>

T24gNy8xNS8xOSA5OjIwIEFNLCBDaHJpc3RvcGggSGVsbHdpZyB3cm90ZToNCj4gT2ssDQo+IA0K
PiBJJ3ZlIGZvbGRlZCB0aGUgbWluaW1hbCBzMzkwIGZpeCBpbiwgcGxlYXNlIGJvdGggZG91Ymxl
IGNoZWNrIHRoYXQgdGhpcw0KPiBpcyBvayBhcyB0aGUgbWluaW1hbGx5IGludmFzaXZlIGZpeDoN
Cg0KTG9va3MgZ29vZCB0byBtZS4NCg0KVGhhbmtzLA0KVG9tDQoNCj4gDQo+IGh0dHA6Ly9naXQu
aW5mcmFkZWFkLm9yZy91c2Vycy9oY2gvZG1hLW1hcHBpbmcuZ2l0L2NvbW1pdGRpZmYvN2JiOWJi
Y2VlODg0NWFmNjYzYTdhNjBkZjllMmNjMjQ0MjJiM2RlNQ0KPiANCj4gVGhlIHMzOTAgZml4IHRv
IGNsZWFuIHVwIHNldl9hY3RpdmUgY2FuIHRoZW4gZ28gaW50byB0aGUgc2VyaWVzIHRoYXQNCj4g
VGhpYWdvIGlzIHdvcmtpbmcgb24uDQo+IA0K
