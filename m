From: Wen Congyang <wency@cn.fujitsu.com>
Subject: Re: [RFC PATCH v5 12/19] memory-hotplug: introduce new function
 arch_remove_memory()
Date: Wed, 01 Aug 2012 09:42:22 +0800
Message-ID: <5018897E.4040109@cn.fujitsu.com>
References: <50126B83.3050201@cn.fujitsu.com>	<50126E2F.8010301@cn.fujitsu.com>	<20120730102305.GB3631@osiris.boeblingen.de.ibm.com>	<50166379.4090305@cn.fujitsu.com>
 <20120731144000.33fd4a0a@thinkpad>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
In-Reply-To: <20120731144000.33fd4a0a@thinkpad>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Errors-To: linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linux-acpi/>
List-Post: <mailto:linux-acpi@vger.kernel.org>
To: gerald.schaefer@de.ibm.com
Cc: linux-s390@vger.kernel.org, linux-ia64@vger.kernel.org, len.brown@intel.com, linux-acpi@vger.kernel.org, linux-sh@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-kernel@vger.kernel.org, cmetcalf@tilera.com, linux-mm@kvack.org, Yasuaki ISIMATU <isimatu.yasuaki@jp.fujitsu.com>, paulus@samba.org, minchan.kim@gmail.com, kosaki.motohiro@jp.fujitsu.com, rientjes@google.com, cl@linux.com, linuxppc-dev@lists.ozlabs.org, akpm@linux-foundation.org, liuj97@gmail.com
List-ID: <linux-s390.vger.kernel.org>

QXQgMDcvMzEvMjAxMiAwODo0MCBQTSwgR2VyYWxkIFNjaGFlZmVyIFdyb3RlOgo+IE9uIE1vbiwg
MzAgSnVsIDIwMTIgMTg6MzU6MzcgKzA4MDAKPiBXZW4gQ29uZ3lhbmcgPHdlbmN5QGNuLmZ1aml0
c3UuY29tPiB3cm90ZToKPiAKPj4gQXQgMDcvMzAvMjAxMiAwNjoyMyBQTSwgSGVpa28gQ2Fyc3Rl
bnMgV3JvdGU6Cj4+PiBPbiBGcmksIEp1bCAyNywgMjAxMiBhdCAwNjozMjoxNVBNICswODAwLCBX
ZW4gQ29uZ3lhbmcgd3JvdGU6Cj4+Pj4gV2UgZG9uJ3QgY2FsbCBfX2FkZF9wYWdlcygpIGRpcmVj
dGx5IGluIHRoZSBmdW5jdGlvbiBhZGRfbWVtb3J5KCkKPj4+PiBiZWNhdXNlIHNvbWUgb3RoZXIg
YXJjaGl0ZWN0dXJlIHJlbGF0ZWQgdGhpbmdzIG5lZWQgdG8gYmUgZG9uZQo+Pj4+IGJlZm9yZSBv
ciBhZnRlciBjYWxsaW5nIF9fYWRkX3BhZ2VzKCkuIFNvIHdlIHNob3VsZCBpbnRyb2R1Y2UKPj4+
PiBhIG5ldyBmdW5jdGlvbiBhcmNoX3JlbW92ZV9tZW1vcnkoKSB0byByZXZlcnQgdGhlIHRoaW5n
cwo+Pj4+IGRvbmUgaW4gYXJjaF9hZGRfbWVtb3J5KCkuCj4+Pj4KPj4+PiBOb3RlOiB0aGUgZnVu
Y3Rpb24gZm9yIHMzOTAgaXMgbm90IGltcGxlbWVudGVkKEkgZG9uJ3Qga25vdyBob3cgdG8KPj4+
PiBpbXBsZW1lbnQgaXQgZm9yIHMzOTApLgo+Pj4KPj4+IFRoZXJlIGlzIG5vIGhhcmR3YXJlIG9y
IGZpcm13YXJlIGludGVyZmFjZSB3aGljaCBjb3VsZCB0cmlnZ2VyIGEKPj4+IGhvdCBtZW1vcnkg
cmVtb3ZlIG9uIHMzOTAuIFNvIHRoZXJlIGlzIG5vdGhpbmcgdGhhdCBuZWVkcyB0byBiZQo+Pj4g
aW1wbGVtZW50ZWQuCj4+Cj4+IFRoYW5rcyBmb3IgcHJvdmlkaW5nIHRoaXMgaW5mb3JtYXRpb24u
Cj4+Cj4+IEFjY29yZGluZyB0byB0aGlzLCBhcmNoX3JlbW92ZV9tZW1vcnkoKSBmb3IgczM5MCBj
YW4ganVzdCByZXR1cm4KPj4gLUVCVVNZLgo+IAo+IFllcywgYnV0IHRoZXJlIGlzIGEgcHJvdG90
eXBlIG1pc21hdGNoIGZvciBhcmNoX3JlbW92ZV9tZW1vcnkoKSBvbiBzMzkwCj4gYW5kIGFsc28g
b3RoZXIgYXJjaGl0ZWN0dXJlcyAodTY0IHZzLiB1bnNpZ25lZCBsb25nKS4KPiAKPiBhcmNoL3Mz
OTAvbW0vaW5pdC5jOjI2MjogZXJyb3I6IGNvbmZsaWN0aW5nIHR5cGVzIGZvcgo+IOKAmGFyY2hf
cmVtb3ZlX21lbW9yeeKAmSBpbmNsdWRlL2xpbnV4L21lbW9yeV9ob3RwbHVnLmg6ODg6IGVycm9y
OiBwcmV2aW91cwo+IGRlY2xhcmF0aW9uIG9mIOKAmGFyY2hfcmVtb3ZlX21lbW9yeeKAmSB3YXMg
aGVyZQo+IAo+IEluIG1lbW9yeV9ob3RwbHVnLmggeW91IGhhdmU6Cj4gZXh0ZXJuIGludCBhcmNo
X3JlbW92ZV9tZW1vcnkodW5zaWduZWQgbG9uZyBzdGFydCwgdW5zaWduZWQgbG9uZyBzaXplKTsK
PiAKPiBPbiBhbGwgYXJjaHMgb3RoZXIgdGhhbiB4ODYgeW91IGhhdmU6Cj4gaW50IGFyY2hfcmVt
b3ZlX21lbW9yeSh1NjQgc3RhcnQsIHU2NCBzaXplKQoKVGhhbmtzIGZvciBwb2ludGluZyBpdCBv
dXQuIEkgd2lsbCBmaXggaXQuCgpXZW4gQ29uZ3lhbmcKCj4gCj4gLS0KPiBUbyB1bnN1YnNjcmli
ZSBmcm9tIHRoaXMgbGlzdDogc2VuZCB0aGUgbGluZSAidW5zdWJzY3JpYmUgbGludXgta2VybmVs
IiBpbgo+IHRoZSBib2R5IG9mIGEgbWVzc2FnZSB0byBtYWpvcmRvbW9Admdlci5rZXJuZWwub3Jn
Cj4gTW9yZSBtYWpvcmRvbW8gaW5mbyBhdCAgaHR0cDovL3ZnZXIua2VybmVsLm9yZy9tYWpvcmRv
bW8taW5mby5odG1sCj4gUGxlYXNlIHJlYWQgdGhlIEZBUSBhdCAgaHR0cDovL3d3dy50dXgub3Jn
L2xrbWwvCj4gCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
XwpMaW51eHBwYy1kZXYgbWFpbGluZyBsaXN0CkxpbnV4cHBjLWRldkBsaXN0cy5vemxhYnMub3Jn
Cmh0dHBzOi8vbGlzdHMub3psYWJzLm9yZy9saXN0aW5mby9saW51eHBwYy1kZXY=
