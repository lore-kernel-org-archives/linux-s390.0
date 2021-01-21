Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: Re: [PATCH v4 1/2] drivers/misc: sysgenid: add system generation id driver
From: "Catangiu, Adrian Costin" <acatan@amazon.com>
Date: Thu, 21 Jan 2021 09:54:27 +0000
Message-ID: <0EFE3365-1698-4BFB-B2F2-BEF1A2634E45@amazon.com>
References: <1610453760-13812-1-git-send-email-acatan@amazon.com>
 <1610453760-13812-2-git-send-email-acatan@amazon.com>
 <X/2fP9LNWXvp7up9@kroah.com>
In-Reply-To: <X/2fP9LNWXvp7up9@kroah.com>
Content-Language: en-GB
Content-Type: text/plain; charset="utf-8"
Content-ID: <AC44F688DB044F439484826026445BBE@amazon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: base64
List-ID: <linux-s390.vger.kernel.org>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>, "Graf (AWS), Alexander" <graf@amazon.de>, "arnd@arndb.de" <arnd@arndb.de>, "ebiederm@xmission.com" <ebiederm@xmission.com>, "rppt@kernel.org" <rppt@kernel.org>, "0x7f454c46@gmail.com" <0x7f454c46@gmail.com>, "borntraeger@de.ibm.com" <borntraeger@de.ibm.com>, "Jason@zx2c4.com" <Jason@zx2c4.com>, "jannh@google.com" <jannh@google.com>, "w@1wt.eu" <w@1wt.eu>, "MacCarthaigh, Colm" <colmmacc@amazon.com>, "luto@kernel.org" <luto@kernel.org>, "tytso@mit.edu" <tytso@mit.edu>, "ebiggers@kernel.org" <ebiggers@kernel.org>, "Woodhouse, David" <dwmw@amazon.co.uk>, "bonzini@gnu.org" <bonzini@gnu.org>, "Singh, Balbir" <sblbir@amazon.com>, "Weiss, Radu" <raduweis@amazon.com>, "corbet@lwn.net" <corbet@lwn.net>, "mst@redhat.com" <mst@redhat.com>, "mhocko@kernel.org" <mhocko@kernel.org>, "rafael@kernel.org" <rafael@kernel.org>, "pavel@ucw.cz" <pavel@ucw.cz>, "mpe@ellerman.id.au" <mpe@ellerman.id.au>, "areber@redhat.com" <areber@redhat.com>, "ovzxemul@gmail.com" <ovzxemul@gmail.com>, "avagin@gmail.com" <avagin@gmail.com>, "ptikhomirov@virtuozzo.com" <ptikhomirov@virtuozzo.com>, "gil@azul.com" <gil@azul.com>, "asmehra@redhat.com" <asmehra@redhat.com>, "dgunigun@redhat.com" <dgunigun@redhat.com>, "vijaysun@ca.ibm.com" <vijaysun@ca.ibm.com>, "oridgar@gmail.com" <oridgar@gmail.com>, "ghammer@redhat.com" <ghammer@redhat.com>

T24gMTIvMDEvMjAyMSwgMTU6MDcsICJHcmVnIEtIIiA8Z3JlZ2toQGxpbnV4Zm91bmRhdGlvbi5v
cmc+IHdyb3RlOg0KDQogICAgT24gVHVlLCBKYW4gMTIsIDIwMjEgYXQgMDI6MTU6NTlQTSArMDIw
MCwgQWRyaWFuIENhdGFuZ2l1IHdyb3RlOg0KICAgID4gKyAgUGFydGlhbCByZWFkcyBhcmUgbm90
IGFsbG93ZWQgLSByZWFkIGJ1ZmZlciBuZWVkcyB0byBiZSBhdCBsZWFzdA0KICAgID4gKyAgYGBz
aXplb2YodW5zaWduZWQpYGAgaW4gc2l6ZS4NCg0KICAgICJzaXplb2YodW5zaWduZWQpIj8gIEhv
dyBhYm91dCBiZWluZyBzcGVjaWZpYyBhbmQgbWFraW5nIHRoaXMgYSByZWFsICJYDQogICAgYml0
cyBiaWciIHZhbHVlIHBsZWFzZS4NCg0KICAgICJ1bnNpZ25lZCIgZG9lcyBub3Qgd29yayB3ZWxs
IGFjcm9zcyB1c2VyL2tlcm5lbCBib3VuZHJpZXMuICBPaywgdGhhdCdzDQogICAgb24gdW5kZXJz
dGF0ZW1lbnQsIHRoZSBjb3JyZWN0IHRoaW5nIGlzICJkb2VzIG5vdCB3b3JrIGF0IGFsbCIuDQoN
CiAgICBQbGVhc2UgYmUgc3BlY2lmaWMgaW4geW91ciBhcGlzLg0KDQogICAgVGhpcyBpcyBsaXN0
ZWQgZWxzZXdoZXJlIGFsc28uDQoNClJpZ2h0LCB3aWxsIGRvIQ0KDQogICAgPiArICAtIFNZU0dF
TklEX0dFVF9PVVREQVRFRF9XQVRDSEVSUzogaW1tZWRpYXRlbHkgcmV0dXJucyB0aGUgbnVtYmVy
IG9mDQogICAgPiArICAgICpvdXRkYXRlZCogd2F0Y2hlcnMgLSBudW1iZXIgb2YgZmlsZSBkZXNj
cmlwdG9ycyB0aGF0IHdlcmUgb3Blbg0KICAgID4gKyAgICBkdXJpbmcgYSBzeXN0ZW0gZ2VuZXJh
dGlvbiBjaGFuZ2UsIGFuZCB3aGljaCBoYXZlIG5vdCB5ZXQgY29uZmlybWVkDQogICAgPiArICAg
IHRoZSBuZXcgZ2VuZXJhdGlvbiBjb3VudGVyLg0KDQogICAgQnV0IHRoaXMgbnVtYmVyIGNhbiBp
bnN0YW50bHkgY2hhbmdlIGFmdGVyIGl0IGlzIHJlYWQsIHdoYXQgZ29vZCBpcyBpdD8NCiAgICBJ
dCBzaG91bGQgbmV2ZXIgYmUgcmVsaWVkIG9uLCBzbyB3aHkgaXMgdGhpcyBuZWVkZWQgYXQgYWxs
Pw0KDQogICAgV2hhdCBjYW4gdXNlcnNwYWNlIGRvIHdpdGggdGhpcyBpbmZvcm1hdGlvbj8NCg0K
VGhhdCBpcyB0cnVlLCBhIHVzZXJzcGFjZSBwcm9jZXNzIGVpdGhlciBoYXMgdG8gd2FpdCBmb3Ig
YWxsIHRvIGFkanVzdCB0byB0aGUgbmV3IGdlbmVyYXRpb24NCm9yIG5vdCBjYXJlIGFib3V0IG90
aGVyIHByb2Nlc3Nlcy4gSW50ZXJtZWRpYXRlIHByb2JpbmcgZG9lc24ndCBicmluZyByZWFsIHZh
bHVlLiBXaWxsIHJlbW92ZS4NCg0KICAgIHRoYW5rcywNCg0KICAgIGdyZWcgay1oDQoNClRoYW5r
cyBmb3IgdGhlIGZlZWRiYWNrIQ0KQWRyaWFuLg0KDQoKCgpBbWF6b24gRGV2ZWxvcG1lbnQgQ2Vu
dGVyIChSb21hbmlhKSBTLlIuTC4gcmVnaXN0ZXJlZCBvZmZpY2U6IDI3QSBTZi4gTGF6YXIgU3Ry
ZWV0LCBVQkM1LCBmbG9vciAyLCBJYXNpLCBJYXNpIENvdW50eSwgNzAwMDQ1LCBSb21hbmlhLiBS
ZWdpc3RlcmVkIGluIFJvbWFuaWEuIFJlZ2lzdHJhdGlvbiBudW1iZXIgSjIyLzI2MjEvMjAwNS4K
