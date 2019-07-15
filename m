Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mail-eopbgr800075.outbound.protection.outlook.com ([40.107.80.75]:39488
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730257AbfGOPot (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Mon, 15 Jul 2019 11:44:49 -0400
From: "Lendacky, Thomas" <Thomas.Lendacky@amd.com>
Subject: Re: [PATCH 3/3] fs/core/vmcore: Move sev_active() reference to x86
 arch code
Date: Mon, 15 Jul 2019 15:44:45 +0000
Message-ID: <56b79040-257b-3a89-c9d2-5842594cad17@amd.com>
References: <20190712053631.9814-1-bauerman@linux.ibm.com>
 <20190712053631.9814-4-bauerman@linux.ibm.com>
 <20190712150912.3097215e.pasic@linux.ibm.com>
 <87tvbqgboc.fsf@morokweng.localdomain>
 <20190715160317.7e3dfb33.pasic@linux.ibm.com> <20190715143039.GA6892@lst.de>
In-Reply-To: <20190715143039.GA6892@lst.de>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <E0FC09AEBDB7CF40BCF8F08977DC2498@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Christoph Hellwig <hch@lst.de>, Halil Pasic <pasic@linux.ibm.com>
Cc: Thiago Jung Bauermann <bauerman@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, "x86@kernel.org" <x86@kernel.org>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Alexey Dobriyan <adobriyan@gmail.com>, Mike Anderson <andmike@linux.ibm.com>, Ram Pai <linuxram@us.ibm.com>

T24gNy8xNS8xOSA5OjMwIEFNLCBDaHJpc3RvcGggSGVsbHdpZyB3cm90ZToNCj4gT24gTW9uLCBK
dWwgMTUsIDIwMTkgYXQgMDQ6MDM6MTdQTSArMDIwMCwgSGFsaWwgUGFzaWMgd3JvdGU6DQo+Pj4g
SSB0aG91Z2h0IGFib3V0IHRoYXQgYnV0IGNvdWxkbid0IHB1dCBteSBmaW5nZXIgb24gYSBnZW5l
cmFsIGNvbmNlcHQuDQo+Pj4gSXMgaXQgImd1ZXN0IHdpdGggbWVtb3J5IGluYWNjZXNzaWJsZSB0
byB0aGUgaG9zdCI/DQo+Pj4NCj4+DQo+PiBXZWxsLCBmb3JjZV9kbWFfdW5lbmNyeXB0ZWQoKSBp
cyBhIG11Y2ggYmV0dGVyIG5hbWUgdGhhdG4gc2V2X2FjdGl2ZSgpOg0KPj4gczM5MCBoYXMgbm8g
QU1EIFNFViwgdGhhdCBpcyBzdXJlLCBidXQgZm9yIHZpcnRpbyB0byB3b3JrIHdlIGRvIG5lZWQg
dG8NCj4+IG1ha2Ugb3VyIGRtYSBhY2Nlc3NpYmxlIHRvIHRoZSBoeXBlcnZpc29yLiBZZXMsIHlv
dXIgImd1ZXN0IHdpdGggbWVtb3J5DQo+PiBpbmFjY2Vzc2libGUgdG8gdGhlIGhvc3QiIHNob3dz
IGludG8gdGhlIHJpZ2h0IGRpcmVjdGlvbiBJTUhPLg0KPj4gVW5mb3J0dW5hdGVseSBJIGRvbid0
IGhhdmUgdG9vIG1hbnkgY3ljbGVzIHRvIHNwZW5kIG9uIHRoaXMgcmlnaHQgbm93Lg0KPiANCj4g
SW4geDg2IGl0IG1lYW5zIHRoYXQgd2UgbmVlZCB0byByZW1vdmUgZG1hIGVuY3J5cHRpb24gdXNp
bmcNCj4gc2V0X21lbW9yeV9kZWNyeXB0ZWQgYmVmb3JlIHVzaW5nIGl0IGZvciBETUEgcHVycG9z
ZXMuICBJbiB0aGUgU0VWDQo+IGNhc2UgdGhhdCBzZWVtcyB0byBiZSBzbyB0aGF0IHRoZSBoeXBl
cnZpc29yIGNhbiBhY2Nlc3MgaXQsIGluIHRoZSBTTUUNCj4gY2FzZSB0aGF0IFRvbSBqdXN0IGZp
eGVzIGl0IGlzIGJlY2F1c2UgdGhlcmUgaXMgYW4gZW5jcnlwdGVkIGJpdCBzZXQNCj4gaW4gdGhl
IHBoeXNpY2FsIGFkZHJlc3MsIGFuZCBpZiB0aGUgZGV2aWNlIGRvZXNuJ3Qgc3VwcG9ydCBhIGxh
cmdlDQo+IGVub3VnaCBETUEgYWRkcmVzcyB0aGUgZGlyZWN0IG1hcHBpbmcgY29kZSBoYXMgdG8g
ZW5jcnlwdCB0aGUgcGFnZXMNCj4gdXNlZCBmb3IgdGhlIGNvbnRpZ291cyBhbGxvY2F0aW9uLg0K
DQpKdXN0IGEgY29ycmVjdGlvbi9jbGFyaWZpY2F0aW9uLi4uDQoNCkZvciBTTUUsIHdoZW4gYSBk
ZXZpY2UgZG9lc24ndCBzdXBwb3J0IGEgbGFyZ2UgZW5vdWdoIERNQSBhZGRyZXNzIHRvDQphY2Nv
bW1vZGF0ZSB0aGUgZW5jcnlwdGlvbiBiaXQgYXMgcGFydCBvZiB0aGUgRE1BIGFkZHJlc3MsIHRo
ZSBkaXJlY3QNCm1hcHBpbmcgY29kZSBoYXMgdG8gcHJvdmlkZSB1bi1lbmNyeXB0ZWQgcGFnZXMu
IEZvciB1bi1lbmNyeXB0ZWQgcGFnZXMsDQp0aGUgRE1BIGFkZHJlc3Mgbm93IGRvZXMgbm90IGlu
Y2x1ZGUgdGhlIGVuY3J5cHRpb24gYml0LCBtYWtpbmcgaXQNCmFjY2VwdGFibGUgdG8gdGhlIGRl
dmljZS4gU2luY2UgdGhlIGRldmljZSBpcyBub3cgdXNpbmcgYSBETUEgYWRkcmVzcw0Kd2l0aG91
dCB0aGUgZW5jcnlwdGlvbiBiaXQsIHRoZSBwaHlzaWNhbCBhZGRyZXNzIGluIHRoZSBDUFUgcGFn
ZSB0YWJsZQ0KbXVzdCBtYXRjaCAodGhlIGNhbGwgdG8gc2V0X21lbW9yeV9kZWNyeXB0ZWQpIHNv
IHRoYXQgYm90aCB0aGUgZGV2aWNlIGFuZA0KdGhlIENQVSBpbnRlcmFjdCBpbiB0aGUgc2FtZSB3
YXkgd2l0aCB0aGUgbWVtb3J5Lg0KDQpUaGFua3MsDQpUb20NCg0KPiANCj4+IEJlaW5nIG9uIGNj
IGZvciB5b3VyIHBhdGNoIG1hZGUgbWUgcmVhbGl6ZSB0aGF0IHRoaW5ncyBnb3QgYnJva2VuIG9u
DQo+PiBzMzkwLiBUaGFua3MhIEkndmUgc2VudCBvdXQgYSBwYXRjaCB0aGF0IGZpeGVzIHByb3R2
aXJ0LCBidXQgd2UgYXJlIGdvaW5nDQo+PiB0byBiZW5lZml0IGZyb20geW91ciBjbGVhbnVwcy4g
SSB0aGluayB3aXRoIHlvdXIgY2xlYW51cHMgYW5kIHRoYXQgcGF0Y2gNCj4+IG9mIG1pbmUgYm90
aCBzZXZfYWN0aXZlKCkgYW5kIHNtZV9hY3RpdmUoKSBjYW4gYmUgcmVtb3ZlZC4gRmVlbCBmcmVl
IHRvDQo+PiBkbyBzby4gSWYgbm90LCBJIGNhbiBhdHRlbmQgdG8gaXQgYXMgd2VsbC4NCj4gDQo+
IFllcywgSSB0aGluayB3aXRoIHRoZSBkbWEtbWFwcGluZyBmaXggYW5kIHRoaXMgc2VyaWVzIHNt
ZV9hY3RpdmUgYW5kDQo+IHNldl9hY3RpdmUgc2hvdWxkIGJlIGdvbmUgZnJvbSBjb21tb24gY29k
ZS4gIFdlIHNob3VsZCBhbHNvIGJlIGFibGUNCj4gdG8gcmVtb3ZlIHRoZSBleHBvcnRzIHg4NiBo
YXMgZm9yIHRoZW0uDQo+IA0KPiBJJ2xsIHdhaXQgYSBmZXcgZGF5cyBhbmQgd2lsbCB0aGVuIGZl
ZWQgdGhlIGRtYS1tYXBwaW5nIGZpeCB0byBMaW51cywNCj4gaXQgbWlnaHQgbWFrZSBzZW5zZSB0
byBlaXRoZXIgcmViYXNlIFRoaWFnb3Mgc2VyaWVzIG9uIHRvcCBvZiB0aGUNCj4gZG1hLW1hcHBp
bmcgZm9yLW5leHQgYnJhbmNoLCBvciB3YWl0IGEgZmV3IGRheXMgYmVmb3JlIHJlcG9zdGluZy4N
Cj4gDQo=
