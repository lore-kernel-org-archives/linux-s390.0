From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [PATCH 6/6] s390: scrub registers on kernel entry and KVM exit
Date: Fri, 19 Jan 2018 08:57:51 +0100
Message-ID: <d3950440-d76f-dee4-1e30-9f287dc18fd2@de.ibm.com>
References: <1516182519-10623-1-git-send-email-schwidefsky@de.ibm.com>
 <1516182519-10623-7-git-send-email-schwidefsky@de.ibm.com>
 <e0d91f92-a9b5-f602-3f81-334b7ff381d9@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="gbk"
Content-Transfer-Encoding: base64
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <e0d91f92-a9b5-f602-3f81-334b7ff381d9@linux.vnet.ibm.com>
Content-Language: en-US
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: QingFeng Hao <haoqf@linux.vnet.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, kvm@vger.kernel.org
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jon Masters <jcm@redhat.com>, Marcus Meissner <meissner@suse.de>, Jiri Kosina <jkosina@suse.cz>
List-ID: <linux-s390.vger.kernel.org>

CgpPbiAwMS8xOS8yMDE4IDA3OjI5IEFNLCBRaW5nRmVuZyBIYW8gd3JvdGU6Cj4gCj4gCj4g1Nog
MjAxOC8xLzE3IDE3OjQ4LCBNYXJ0aW4gU2Nod2lkZWZza3kg0LS1wDoKPj4gQ2xlYXIgYWxsIHVz
ZXIgc3BhY2UgcmVnaXN0ZXJzIG9uIGVudHJ5IHRvIHRoZSBrZXJuZWwgYW5kIGFsbCBLVk0gZ3Vl
c3QKPj4gcmVnaXN0ZXJzIG9uIEtWTSBndWVzdCBleGl0IGlmIHRoZSByZWdpc3RlciBkb2VzIG5v
dCBjb250YWluIGVpdGhlciBhCj4+IHBhcmFtZXRlciBvciBhIHJlc3VsdCB2YWx1ZS4KPiBJIGFt
IG5vdCBzdXJlIGlmIEkgdW5kZXJzdGFuZCB0aGlzIGJ1dCBpdCB3aWxsIGJlIHNhZmVyPwoKSXQg
aXN0IHNpbWlsYXIgdG8gY29tbWl0IDBjYjViMzA2OThmZCAoImt2bTogdm14OiBTY3J1YiBoYXJk
d2FyZSBHUFJzIGF0IFZNLWV4aXQiKS4KVGhlIGlkZWEgaXMgdG8gbWluaW1pemUgcG90ZW50aWFs
IHBheWxvYWQgY2hhbm5lbHMuCgo+IEFuZCBjYW4gd2UgYWJzdHJhY3QgdGhlIG9wZXJhdGlvbnMg
dG8gYmUgYSBtYWNybyBsaWtlIENMRUFSX1JFR183PwoKTm8sIHBsZWFzZS4KeGdyICVyNywlcjcK
aXMgYWJzb2x1dGVseSBjbGVhciB3aGF0IGl0IGRvZXMsIGEgTUFDUk8gb2Z0ZW4gaXMgbm90Lgo=
