Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from smtp-fw-6001.amazon.com ([52.95.48.154]:2068 "EHLO
        smtp-fw-6001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230043AbhBIOp4 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 9 Feb 2021 09:45:56 -0500
Subject: Re: [PATCH v5 1/2] drivers/misc: sysgenid: add system generation id driver
From: "Catangiu, Adrian Costin" <acatan@amazon.com>
Date: Tue, 9 Feb 2021 14:44:58 +0000
Message-ID: <6D86B655-C57C-4E58-87D2-507D62E3B820@amazon.com>
References: <1612200294-17561-1-git-send-email-acatan@amazon.com>
 <1612200294-17561-2-git-send-email-acatan@amazon.com>
 <YBk/7YzxqPJM3Bm8@kroah.com>
In-Reply-To: <YBk/7YzxqPJM3Bm8@kroah.com>
Content-Language: en-GB
Content-Type: text/plain; charset="utf-8"
Content-ID: <D4110FB330449B40B4E7F8905E6D7C0E@amazon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: base64
List-ID: <linux-s390.vger.kernel.org>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>, "Graf (AWS), Alexander" <graf@amazon.de>, "rdunlap@infradead.org" <rdunlap@infradead.org>, "arnd@arndb.de" <arnd@arndb.de>, "ebiederm@xmission.com" <ebiederm@xmission.com>, "rppt@kernel.org" <rppt@kernel.org>, "0x7f454c46@gmail.com" <0x7f454c46@gmail.com>, "borntraeger@de.ibm.com" <borntraeger@de.ibm.com>, "Jason@zx2c4.com" <Jason@zx2c4.com>, "jannh@google.com" <jannh@google.com>, "w@1wt.eu" <w@1wt.eu>, "MacCarthaigh, Colm" <colmmacc@amazon.com>, "luto@kernel.org" <luto@kernel.org>, "tytso@mit.edu" <tytso@mit.edu>, "ebiggers@kernel.org" <ebiggers@kernel.org>, "Woodhouse, David" <dwmw@amazon.co.uk>, "bonzini@gnu.org" <bonzini@gnu.org>, "Singh, Balbir" <sblbir@amazon.com>, "Weiss, Radu" <raduweis@amazon.com>, "corbet@lwn.net" <corbet@lwn.net>, "mst@redhat.com" <mst@redhat.com>, "mhocko@kernel.org" <mhocko@kernel.org>, "rafael@kernel.org" <rafael@kernel.org>, "pavel@ucw.cz" <pavel@ucw.cz>, "mpe@ellerman.id.au" <mpe@ellerman.id.au>, "areber@redhat.com" <areber@redhat.com>, "ovzxemul@gmail.com" <ovzxemul@gmail.com>, "avagin@gmail.com" <avagin@gmail.com>, "ptikhomirov@virtuozzo.com" <ptikhomirov@virtuozzo.com>, "gil@azul.com" <gil@azul.com>, "asmehra@redhat.com" <asmehra@redhat.com>, "dgunigun@redhat.com" <dgunigun@redhat.com>, "vijaysun@ca.ibm.com" <vijaysun@ca.ibm.com>, "oridgar@gmail.com" <oridgar@gmail.com>, "ghammer@redhat.com" <ghammer@redhat.com>

T24gMDIvMDIvMjAyMSwgMTQ6MDUsICJHcmVnIEtIIiA8Z3JlZ2toQGxpbnV4Zm91bmRhdGlvbi5v
cmc+IHdyb3RlOg0KDQogICAgT24gTW9uLCBGZWIgMDEsIDIwMjEgYXQgMDc6MjQ6NTNQTSArMDIw
MCwgQWRyaWFuIENhdGFuZ2l1IHdyb3RlOg0KICAgID4gK0VYUE9SVF9TWU1CT0woc3lzZ2VuaWRf
YnVtcF9nZW5lcmF0aW9uKTsNCg0KICAgIEVYUE9SVF9TWU1CT0xfR1BMKCk/ICBJIGhhdmUgdG8g
YXNrLi4uDQoNCkdvb2QgY2F0Y2ghIFdpbGwgdXBkYXRlLg0KDQoKCgpBbWF6b24gRGV2ZWxvcG1l
bnQgQ2VudGVyIChSb21hbmlhKSBTLlIuTC4gcmVnaXN0ZXJlZCBvZmZpY2U6IDI3QSBTZi4gTGF6
YXIgU3RyZWV0LCBVQkM1LCBmbG9vciAyLCBJYXNpLCBJYXNpIENvdW50eSwgNzAwMDQ1LCBSb21h
bmlhLiBSZWdpc3RlcmVkIGluIFJvbWFuaWEuIFJlZ2lzdHJhdGlvbiBudW1iZXIgSjIyLzI2MjEv
MjAwNS4K
