From: QingFeng Hao <haoqf@linux.vnet.ibm.com>
Subject: Re: [PATCH 6/6] s390: scrub registers on kernel entry and KVM exit
Date: Fri, 19 Jan 2018 16:27:08 +0800
Message-ID: <34660999-606f-0cab-6630-4116ad833c77@linux.vnet.ibm.com>
References: <1516182519-10623-1-git-send-email-schwidefsky@de.ibm.com>
 <1516182519-10623-7-git-send-email-schwidefsky@de.ibm.com>
 <e0d91f92-a9b5-f602-3f81-334b7ff381d9@linux.vnet.ibm.com>
 <d3950440-d76f-dee4-1e30-9f287dc18fd2@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="gbk"; format="flowed"
Content-Transfer-Encoding: base64
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <d3950440-d76f-dee4-1e30-9f287dc18fd2@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, kvm@vger.kernel.org
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jon Masters <jcm@redhat.com>, Marcus Meissner <meissner@suse.de>, Jiri Kosina <jkosina@suse.cz>
List-ID: <linux-s390.vger.kernel.org>

CgrU2iAyMDE4LzEvMTkgMTU6NTcsIENocmlzdGlhbiBCb3JudHJhZWdlciDQtLXAOgo+Cj4gT24g
MDEvMTkvMjAxOCAwNzoyOSBBTSwgUWluZ0ZlbmcgSGFvIHdyb3RlOgo+Pgo+PiDU2iAyMDE4LzEv
MTcgMTc6NDgsIE1hcnRpbiBTY2h3aWRlZnNreSDQtLXAOgo+Pj4gQ2xlYXIgYWxsIHVzZXIgc3Bh
Y2UgcmVnaXN0ZXJzIG9uIGVudHJ5IHRvIHRoZSBrZXJuZWwgYW5kIGFsbCBLVk0gZ3Vlc3QKPj4+
IHJlZ2lzdGVycyBvbiBLVk0gZ3Vlc3QgZXhpdCBpZiB0aGUgcmVnaXN0ZXIgZG9lcyBub3QgY29u
dGFpbiBlaXRoZXIgYQo+Pj4gcGFyYW1ldGVyIG9yIGEgcmVzdWx0IHZhbHVlLgo+PiBJIGFtIG5v
dCBzdXJlIGlmIEkgdW5kZXJzdGFuZCB0aGlzIGJ1dCBpdCB3aWxsIGJlIHNhZmVyPwo+IEl0IGlz
dCBzaW1pbGFyIHRvIGNvbW1pdCAwY2I1YjMwNjk4ZmQgKCJrdm06IHZteDogU2NydWIgaGFyZHdh
cmUgR1BScyBhdCBWTS1leGl0IikuCj4gVGhlIGlkZWEgaXMgdG8gbWluaW1pemUgcG90ZW50aWFs
IHBheWxvYWQgY2hhbm5lbHMuCkdvdCBpdCEgdGhhbmtzIGZvciB5b3VyIGV4cGxhbmF0aW9uIQo+
Cj4+IEFuZCBjYW4gd2UgYWJzdHJhY3QgdGhlIG9wZXJhdGlvbnMgdG8gYmUgYSBtYWNybyBsaWtl
IENMRUFSX1JFR183Pwo+IE5vLCBwbGVhc2UuCj4geGdyICVyNywlcjcKPiBpcyBhYnNvbHV0ZWx5
IGNsZWFyIHdoYXQgaXQgZG9lcywgYSBNQUNSTyBvZnRlbiBpcyBub3QuCm5vZCwgdGhpcyBtYWtl
cyBzZW5zZSEKCi0tIApSZWdhcmRzClFpbmdGZW5nIEhhbwo=
