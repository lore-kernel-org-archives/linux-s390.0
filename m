Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from eu-smtp-delivery-151.mimecast.com ([207.82.80.151]:46385 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S372600AbgJVWEJ (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 22 Oct 2020 18:04:09 -0400
From: David Laight <David.Laight@ACULAB.COM>
Subject: RE: Buggy commit tracked to: "Re: [PATCH 2/9] iov_iter: move
 rw_copy_check_uvector() into lib/iov_iter.c"
Date: Thu, 22 Oct 2020 22:04:04 +0000
Message-ID: <15c3f5926f9c4f67b53f1ed26c41a62e@AcuMS.aculab.com>
References: <20201021233914.GR3576660@ZenIV.linux.org.uk>
 <20201022082654.GA1477657@kroah.com>
 <80a2e5fa-718a-8433-1ab0-dd5b3e3b5416@redhat.com>
 <5d2ecb24db1e415b8ff88261435386ec@AcuMS.aculab.com>
 <df2e0758-b8ed-5aec-6adc-a18f499c0179@redhat.com>
 <20201022090155.GA1483166@kroah.com>
 <e04d0c5d-e834-a15b-7844-44dcc82785cc@redhat.com>
 <a1533569-948a-1d5b-e231-5531aa988047@redhat.com>
 <bc0a091865f34700b9df332c6e9dcdfd@AcuMS.aculab.com>
 <5fd6003b-55a6-2c3c-9a28-8fd3a575ca78@redhat.com>
 <20201022132342.GB8781@lst.de>
 <8f1fff0c358b4b669d51cc80098dbba1@AcuMS.aculab.com>
 <CAKwvOdnix6YGFhsmT_mY8ORNPTOsN3HwS33Dr0Ykn-pyJ6e-Bw@mail.gmail.com>
 <CAK8P3a3LjG+ZvmQrkb9zpgov8xBkQQWrkHBPgjfYSqBKGrwT4w@mail.gmail.com>
 <CAKwvOdnhONvrHLAuz_BrAuEpnF5mD9p0YPGJs=NZZ0EZNo7dFQ@mail.gmail.com>
In-Reply-To: <CAKwvOdnhONvrHLAuz_BrAuEpnF5mD9p0YPGJs=NZZ0EZNo7dFQ@mail.gmail.com>
MIME-Version: 1.0
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
List-ID: <linux-s390.vger.kernel.org>
To: 'Nick Desaulniers' <ndesaulniers@google.com>, Arnd Bergmann <arnd@arndb.de>
Cc: Christoph Hellwig <hch@lst.de>, David Hildenbrand <david@redhat.com>, Greg KH <gregkh@linuxfoundation.org>, Al Viro <viro@zeniv.linux.org.uk>, "kernel-team@android.com" <kernel-team@android.com>, Andrew Morton <akpm@linux-foundation.org>, Jens Axboe <axboe@kernel.dk>, David Howells <dhowells@redhat.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>, "linux-parisc@vger.kernel.org" <linux-parisc@vger.kernel.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>, "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>, "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>, "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, "linux-aio@kvack.org" <linux-aio@kvack.org>, "io-uring@vger.kernel.org" <io-uring@vger.kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "keyrings@vger.kernel.org" <keyrings@vger.kernel.org>, "linux-security-module@vger.kernel.org" <linux-security-module@vger.kernel.org>

RnJvbTogTmljayBEZXNhdWxuaWVycw0KPiBTZW50OiAyMiBPY3RvYmVyIDIwMjAgMjA6MDUNCj4g
DQouLi4NCj4gUGFzc2luZyBhbiBgdW5zaWduZWQgbG9uZ2AgYXMgYW4gYHVuc2lnbmVkIGludGAg
ZG9lcyBubyBzdWNoDQo+IG5hcnJvd2luZzogaHR0cHM6Ly9nb2Rib2x0Lm9yZy96L1R2Zk14ZSAo
c2FtZSB2aWNlLXZlcnNhLCBqdXN0IHRhaWwNCj4gY2FsbHMsIG5vIG1hc2tpbmcgaW5zdHJ1Y3Rp
b25zKS4NCg0KUmlnaHQgYnV0IGlzIHRoZSBjYWxsZWQgZnVuY3Rpb24gZ29pbmcgdG8gdXNlIDMy
Yml0IG9wcw0KYW5kL29yIG1hc2sgdGhlIHJlZ2lzdGVyPw0KQ2VydGFpbmx5IHRoYXQgaXMgbGlr
ZWx5IG9uIHg4Ni02NC4NCg0KSSd2ZSByYXRoZXIgbG9zdCB0cmFjayBvZiB3aGVyZSB0aGUgbWFz
a2luZyBpcyBleHBlY3RlZA0KdG8gaGFwcGVuLg0KDQoJRGF2aWQNCg0KLQ0KUmVnaXN0ZXJlZCBB
ZGRyZXNzIExha2VzaWRlLCBCcmFtbGV5IFJvYWQsIE1vdW50IEZhcm0sIE1pbHRvbiBLZXluZXMs
IE1LMSAxUFQsIFVLDQpSZWdpc3RyYXRpb24gTm86IDEzOTczODYgKFdhbGVzKQ0K
