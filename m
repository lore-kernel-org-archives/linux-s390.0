Return-Path: <linux-kernel-owner@vger.kernel.org>
From: "Catangiu, Adrian Costin" <acatan@amazon.com>
Subject: Re: [PATCH] drivers/virt: vmgenid: add vm generation id driver
Date: Tue, 20 Oct 2020 16:54:24 +0000
Message-ID: <9CB99FC7-3EDF-488E-B52C-DE0368A4BC81@amazon.com>
References: <788878CE-2578-4991-A5A6-669DCABAC2F2@amazon.com>
 <CAG48ez0EanBvDyfthe+hAP0OC8iGLNSq2e5wJVz-=ENNGF97_w@mail.gmail.com>
 <20201017033606.GA14014@1wt.eu>
 <CAG48ez0x2S9XuCrANAQbXNi8Jjwm822-fnQSmr-Zr07JgrEs1g@mail.gmail.com>
 <6CC3DB03-27BA-4F5E-8ADA-BE605D83A85C@amazon.com>
 <CAG48ez1ZtvjOs2CEq8-EMosPCd_o7WQ3Mz_+1mDe7OrH2arxFA@mail.gmail.com>
 <20201017053712.GA14105@1wt.eu>
 <CAG48ez1h0ynXfGap_KiHiPVTfcB8NBQJ-2dnj08ZNfuhrW0jWA@mail.gmail.com>
 <20201017064442.GA14117@1wt.eu>
 <CAG48ez3pXLC+eqAXDCniM0a+5yP2XJODDkZqiUTZUOttCE_LbA@mail.gmail.com>
 <CAHmME9qHGSF8w3DoyCP+ud_N0MAJ5_8zsUWx=rxQB1mFnGcu9w@mail.gmail.com>
 <aacdff7a-2af1-4f46-6ab2-2a9d5b865d35@amazon.de>
In-Reply-To: <aacdff7a-2af1-4f46-6ab2-2a9d5b865d35@amazon.de>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <D222EABD850A32409B803CF44A854938@amazon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: base64
List-ID: <linux-s390.vger.kernel.org>
To: "Graf (AWS), Alexander" <graf@amazon.de>, "Jason A. Donenfeld" <Jason@zx2c4.com>, Jann Horn <jannh@google.com>
Cc: Willy Tarreau <w@1wt.eu>, "MacCarthaigh, Colm" <colmmacc@amazon.com>, Andy Lutomirski <luto@kernel.org>, "Theodore Y. Ts'o" <tytso@mit.edu>, Eric Biggers <ebiggers@kernel.org>, "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, kernel list <linux-kernel@vger.kernel.org>, "open list:VIRTIO GPU DRIVER" <virtualization@lists.linux-foundation.org>, "Woodhouse, David" <dwmw@amazon.co.uk>, "bonzini@gnu.org" <bonzini@gnu.org>, "Singh, Balbir" <sblbir@amazon.com>, "Weiss, Radu" <raduweis@amazon.com>, "oridgar@gmail.com" <oridgar@gmail.com>, "ghammer@redhat.com" <ghammer@redhat.com>, Jonathan Corbet <corbet@lwn.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Michael S. Tsirkin" <mst@redhat.com>, Qemu Developers <qemu-devel@nongnu.org>, KVM list <kvm@vger.kernel.org>, Michal Hocko <mhocko@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@ucw.cz>, Linux API <linux-api@vger.kernel.org>, Christian Borntraeger <borntraeger@de.ibm.com>, "mpe@ellerman.id.au" <mpe@ellerman.id.au>, "Mathiske, Bernd" <mathiske@amazon.com>, "Hohensee, Paul" <hohensee@amazon.com>

SGkgYWxsLA0KDQrvu79PbiAxNy8xMC8yMDIwLCAyMTowOSwgIkdyYWYgKEFXUyksIEFsZXhhbmRl
ciIgPGdyYWZAYW1hem9uLmRlPiB3cm90ZToNCiAgICANCiAgICBPbiAxNy4xMC4yMCAxNToyNCwg
SmFzb24gQS4gRG9uZW5mZWxkIHdyb3RlOg0KICAgID4gDQogICAgPiBBZnRlciBkaXNjdXNzaW5n
IHRoaXMgb2ZmbGluZSB3aXRoIEphbm4gYSBiaXQsIEkgaGF2ZSBhIGZldyBnZW5lcmFsDQogICAg
PiBjb21tZW50cyBvbiB0aGUgZGVzaWduIG9mIHRoaXMuDQogICAgPiANCiAgICA+IEZpcnN0LCB0
aGUgVVVJRCBjb21tdW5pY2F0ZWQgYnkgdGhlIGh5cGVydmlzb3Igc2hvdWxkIGJlIGNvbnN1bWVk
IGJ5DQogICAgPiB0aGUga2VybmVsIC0tIGFkZGVkIGFzIGFub3RoZXIgaW5wdXQgdG8gdGhlIHJu
ZyAtLSBhbmQgdGhlbiB1c2Vyc3BhY2UNCiAgICANCiAgICBXZSBkZWZpbml0ZWx5IHdhbnQgYSBr
ZXJuZWwgaW50ZXJuYWwgbm90aWZpZXIgYXMgd2VsbCwgeWVzIDopLg0KDQpXaGF0IHdvdWxkIGJl
IGEgZ2VuZXJpYyBldmVudCB0cmlnZ2VyIG1lY2hhbmlzbSB3ZSBjb3VsZCB1c2UgZnJvbSBhIGtl
cm5lbA0KbW9kdWxlL2RyaXZlciBmb3IgdHJpZ2dlcmluZyBybmcgcmVzZWVkIChwb3NzaWJseSBh
ZGRpbmcgdGhlIHV1aWQgdG8gdGhlIG1peA0KYXMgd2VsbCk/DQoNCiAgDQoNCgoKCkFtYXpvbiBE
ZXZlbG9wbWVudCBDZW50ZXIgKFJvbWFuaWEpIFMuUi5MLiByZWdpc3RlcmVkIG9mZmljZTogMjdB
IFNmLiBMYXphciBTdHJlZXQsIFVCQzUsIGZsb29yIDIsIElhc2ksIElhc2kgQ291bnR5LCA3MDAw
NDUsIFJvbWFuaWEuIFJlZ2lzdGVyZWQgaW4gUm9tYW5pYS4gUmVnaXN0cmF0aW9uIG51bWJlciBK
MjIvMjYyMS8yMDA1Lgo=
