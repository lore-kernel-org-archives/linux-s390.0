Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from smtp-fw-2101.amazon.com ([72.21.196.25]:12501 "EHLO
        smtp-fw-2101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232173AbhBIOrb (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 9 Feb 2021 09:47:31 -0500
Subject: Re: [PATCH v5 1/2] drivers/misc: sysgenid: add system generation id driver
From: "Catangiu, Adrian Costin" <acatan@amazon.com>
Date: Tue, 9 Feb 2021 14:46:32 +0000
Message-ID: <CA221922-DFEE-4771-9590-FADDB74F7399@amazon.com>
References: <1612200294-17561-1-git-send-email-acatan@amazon.com>
 <1612200294-17561-2-git-send-email-acatan@amazon.com>
 <YBlAueoh12esXR2A@kroah.com>
In-Reply-To: <YBlAueoh12esXR2A@kroah.com>
Content-Language: en-GB
Content-Type: text/plain; charset="utf-8"
Content-ID: <078DDECD943E3742BC3EFEB9511AA280@amazon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: base64
List-ID: <linux-s390.vger.kernel.org>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>, "Graf (AWS), Alexander" <graf@amazon.de>, "rdunlap@infradead.org" <rdunlap@infradead.org>, "arnd@arndb.de" <arnd@arndb.de>, "ebiederm@xmission.com" <ebiederm@xmission.com>, "rppt@kernel.org" <rppt@kernel.org>, "0x7f454c46@gmail.com" <0x7f454c46@gmail.com>, "borntraeger@de.ibm.com" <borntraeger@de.ibm.com>, "Jason@zx2c4.com" <Jason@zx2c4.com>, "jannh@google.com" <jannh@google.com>, "w@1wt.eu" <w@1wt.eu>, "MacCarthaigh, Colm" <colmmacc@amazon.com>, "luto@kernel.org" <luto@kernel.org>, "tytso@mit.edu" <tytso@mit.edu>, "ebiggers@kernel.org" <ebiggers@kernel.org>, "Woodhouse, David" <dwmw@amazon.co.uk>, "bonzini@gnu.org" <bonzini@gnu.org>, "Singh, Balbir" <sblbir@amazon.com>, "Weiss, Radu" <raduweis@amazon.com>, "corbet@lwn.net" <corbet@lwn.net>, "mst@redhat.com" <mst@redhat.com>, "mhocko@kernel.org" <mhocko@kernel.org>, "rafael@kernel.org" <rafael@kernel.org>, "pavel@ucw.cz" <pavel@ucw.cz>, "mpe@ellerman.id.au" <mpe@ellerman.id.au>, "areber@redhat.com" <areber@redhat.com>, "ovzxemul@gmail.com" <ovzxemul@gmail.com>, "avagin@gmail.com" <avagin@gmail.com>, "ptikhomirov@virtuozzo.com" <ptikhomirov@virtuozzo.com>, "gil@azul.com" <gil@azul.com>, "asmehra@redhat.com" <asmehra@redhat.com>, "dgunigun@redhat.com" <dgunigun@redhat.com>, "vijaysun@ca.ibm.com" <vijaysun@ca.ibm.com>, "oridgar@gmail.com" <oridgar@gmail.com>, "ghammer@redhat.com" <ghammer@redhat.com>

T24gMDIvMDIvMjAyMSwgMTQ6MDksICJHcmVnIEtIIiA8Z3JlZ2toQGxpbnV4Zm91bmRhdGlvbi5v
cmc+IHdyb3RlOg0KDQogICAgT24gTW9uLCBGZWIgMDEsIDIwMjEgYXQgMDc6MjQ6NTNQTSArMDIw
MCwgQWRyaWFuIENhdGFuZ2l1IHdyb3RlOg0KICAgID4gK3N0YXRpYyBsb25nIHN5c2dlbmlkX2lv
Y3RsKHN0cnVjdCBmaWxlICpmaWxlLA0KICAgID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIHVuc2lnbmVkIGludCBjbWQsIHVuc2lnbmVkIGxvbmcgYXJn
KQ0KDQogICAgVmVyeSBvZGQgaW5kZW50YXRpb24gc3R5bGUsIGNoZWNrcGF0Y2gucGwgZGlkbid0
IGNhdGNoIHRoaXM/DQoNCkNoZWNrcGF0Y2gucGwgaXMgaGFwcHkgd2l0aCB0aGlzLCB5ZXMuDQpX
aWxsIGNoYW5nZSBpdCB0byBhIHNpbmdsZSB0YWIgbm9uZXRoZWxlc3Mgc2luY2UgaXQgZG9lcyBs
b29rIHdlaXJkIDopDQoNCgoKCkFtYXpvbiBEZXZlbG9wbWVudCBDZW50ZXIgKFJvbWFuaWEpIFMu
Ui5MLiByZWdpc3RlcmVkIG9mZmljZTogMjdBIFNmLiBMYXphciBTdHJlZXQsIFVCQzUsIGZsb29y
IDIsIElhc2ksIElhc2kgQ291bnR5LCA3MDAwNDUsIFJvbWFuaWEuIFJlZ2lzdGVyZWQgaW4gUm9t
YW5pYS4gUmVnaXN0cmF0aW9uIG51bWJlciBKMjIvMjYyMS8yMDA1Lgo=
