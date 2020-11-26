Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from szxga07-in.huawei.com ([45.249.212.35]:8402 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730067AbgKZB1p (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 25 Nov 2020 20:27:45 -0500
Subject: Re: [PATCH] scsi: zfcp: fix use-after-free in zfcp_unit_remove
References: <20201120074854.31754-1-miaoqinglang@huawei.com>
 <20201125170658.GB8578@t480-pf1aa2c2>
From: Qinglang Miao <miaoqinglang@huawei.com>
Message-ID: <4c65bead-2553-171e-54d2-87a9de0330e8@huawei.com>
Date: Thu, 26 Nov 2020 09:27:41 +0800
MIME-Version: 1.0
In-Reply-To: <20201125170658.GB8578@t480-pf1aa2c2>
Content-Type: text/plain; charset="gbk"; format="flowed"
Content-Transfer-Encoding: base64
List-ID: <linux-s390.vger.kernel.org>
To: Benjamin Block <bblock@linux.ibm.com>
Cc: Steffen Maier <maier@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org

Cgrvv73vv70gMjAyMC8xMS8yNiAxOjA2LCBCZW5qYW1pbiBCbG9jayDQtO+/ve+/vToKPiBPbiBG
cmksIE5vdiAyMCwgMjAyMCBhdCAwMzo0ODo1NFBNICswODAwLCBRaW5nbGFuZyBNaWFvIHdyb3Rl
Ogo+PiBrZnJlZShwb3J0KSBpcyBjYWxsZWQgaW4gcHV0X2RldmljZSgmcG9ydC0+ZGV2KSBzbyB0
aGF0IGZvbGxvd2luZwo+PiB1c2Ugd291bGQgY2F1c2UgdXNlLWFmdGVyLWZyZWUgYnVnLgo+Pgo+
PiBUaGUgZm9ybWVyIHB1dF9kZXZpY2UgaXMgcmVkdW5kYW50IGZvciBkZXZpY2VfdW5yZWdpc3Rl
ciBjb250YWlucwo+PiBwdXRfZGV2aWNlIGFscmVhZHkuIFNvIGp1c3QgcmVtb3ZlIGl0IHRvIGZp
eCB0aGlzLgo+Pgo+PiBGaXhlczogODZiZGYyMThhNzE3ICgiW1NDU0ldIHpmY3A6IGNsZWFudXAg
dW5pdCBzeXNmcyBhdHRyaWJ1dGUgdXNhZ2UiKQo+PiBSZXBvcnRlZC1ieTogSHVsayBSb2JvdCA8
aHVsa2NpQGh1YXdlaS5jb20+Cj4+IFNpZ25lZC1vZmYtYnk6IFFpbmdsYW5nIE1pYW8gPG1pYW9x
aW5nbGFuZ0BodWF3ZWkuY29tPgo+PiAtLS0KPj4gICBkcml2ZXJzL3MzOTAvc2NzaS96ZmNwX3Vu
aXQuYyB8IDIgLS0KPj4gICAxIGZpbGUgY2hhbmdlZCwgMiBkZWxldGlvbnMoLSkKPj4KPj4gZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvczM5MC9zY3NpL3pmY3BfdW5pdC5jIGIvZHJpdmVycy9zMzkwL3Nj
c2kvemZjcF91bml0LmMKPj4gaW5kZXggZTY3YmY3Mzg4Li42NjRiNzc4NTMgMTAwNjQ0Cj4+IC0t
LSBhL2RyaXZlcnMvczM5MC9zY3NpL3pmY3BfdW5pdC5jCj4+ICsrKyBiL2RyaXZlcnMvczM5MC9z
Y3NpL3pmY3BfdW5pdC5jCj4+IEBAIC0yNTUsOCArMjU1LDYgQEAgaW50IHpmY3BfdW5pdF9yZW1v
dmUoc3RydWN0IHpmY3BfcG9ydCAqcG9ydCwgdTY0IGZjcF9sdW4pCj4+ICAgCQlzY3NpX2Rldmlj
ZV9wdXQoc2Rldik7Cj4+ICAgCX0KPj4gICAKPj4gLQlwdXRfZGV2aWNlKCZ1bml0LT5kZXYpOwo+
PiAtCj4+ICAgCWRldmljZV91bnJlZ2lzdGVyKCZ1bml0LT5kZXYpOwo+PiAgPj4gICAJcmV0dXJu
IDA7Cj4gCj4gU2FtZSBhcyBpbiB0aGUgb3RoZXIgbWFpbCBmb3IgYHpmY3Bfc3lzZnNfcG9ydF9y
ZW1vdmVfc3RvcmUoKWAuIFdlCj4gZXhwbGljaXRseSBnZXQgYSBuZXcgcmVmIGluIGBfemZjcF91
bml0X2ZpbmQoKWAsIHNvIHdlIGFsc28gbmVlZCB0byBwdXQKPiB0aGF0IGF3YXkgYWdhaW4uCj4K
U29ycnksIEJlbmphbWluLCBJIGRvbid0IHRoaW5rIHNvLCBiZWNhdXNlIGRldmljZV91bnJlZ2lz
dGVyIGNhbGxzIApwdXRfZGV2aWNlIGluc2lkZS4KCkl0IHNlZW0ncyB0aGF0IGFub3RoZXIgcHV0
X2RldmljZSBiZWZvcmUgb3IgYWZ0ZXIgZGV2aWNlX3VucmVnaXN0ZXIgaXMgCnVzZWxlc3MgYW5k
IGV2ZW4gbWlnaHQgY2F1c2UgYW4gdXNlLWFmdGVyLWZyZWUuCgo=
