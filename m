From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: Re: [PATCH v2 1/2] treewide: remove unused address argument from
 pte_alloc functions
Date: Fri, 12 Oct 2018 20:51:45 +0200
Message-ID: <03b524f3-5f3a-baa0-2254-9c588103d2d6@users.sourceforge.net>
References: <20181012013756.11285-1-joel@joelfernandes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-snps-arc-bounces+gla-linux-snps-arc=m.gmane.org@lists.infradead.org>
In-Reply-To: <20181012013756.11285-1-joel@joelfernandes.org>
Content-Language: en-GB
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-snps-arc>,
 <mailto:linux-snps-arc-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-snps-arc/>
List-Post: <mailto:linux-snps-arc@lists.infradead.org>
List-Help: <mailto:linux-snps-arc-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-snps-arc>,
 <mailto:linux-snps-arc-request@lists.infradead.org?subject=subscribe>
Sender: "linux-snps-arc" <linux-snps-arc-bounces@lists.infradead.org>
Errors-To: linux-snps-arc-bounces+gla-linux-snps-arc=m.gmane.org@lists.infradead.org
List-Archive: <https://lore.kernel.org/kvmarm/>
List-Post: <mailto:kvmarm@lists.cs.columbia.edu>
To: Joel Fernandes <joel@joelfernandes.org>, kernel-janitors@vger.kernel.org
Cc: linux-mips@linux-mips.org, Rich Felker <dalias@libc.org>, linux-ia64@vger.kernel.org, linux-sh@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Catalin Marinas <catalin.marinas@arm.com>, Dave Hansen <dave.hansen@linux.intel.com>, Will Deacon <will.deacon@arm.com>, Michal Hocko <mhocko@kernel.org>, linux-mm@kvack.org, Lokesh Gidra <lokeshgidra@google.com>, sparclinux@vger.kernel.org, linux-riscv@lists.infradead.org, kvmarm@lists.cs.columbia.edu, Jonas Bonn <jonas@southpole.se>, linux-s390@vger.kernel.org, Daniel Colascione <dancol@google.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, Max Filippov <jcmvbkbc@gmail.com>, linux-hexagon@vger.kernel.org, Helge Deller <deller@gmx.de>, "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>, Hugh Dickins <hughd@google.com>, "James E. J. Bottomley" <jejb@parisc-linux.org>, kasan-dev@googlegroups.com, Ingo
List-ID: <linux-s390.vger.kernel.org>

PiBUaGUgY2hhbmdlcyB3ZXJlIG9idGFpbmVkIGJ5IGFwcGx5aW5nIHRoZSBmb2xsb3dpbmcgQ29j
Y2luZWxsZSBzY3JpcHQuCgpBIGJpdCBvZiBjbGFyaWZpY2F0aW9uIGhhcHBlbmVkIGZvciBpdHMg
aW1wbGVtZW50YXRpb24gZGV0YWlscy4KaHR0cHM6Ly9zeXN0ZW1lLmxpcDYuZnIvcGlwZXJtYWls
L2NvY2NpLzIwMTgtT2N0b2Jlci8wMDUzNzQuaHRtbAoKSSBoYXZlIHRha2VuIGFsc28gYW5vdGhl
ciBsb29rIGF0IHRoZSBmb2xsb3dpbmcgU21QTCBjb2RlLgoKCj4gaWRlbnRpZmllciBmbiA9fgo+
ICJeKF9fcHRlX2FsbG9jfHB0ZV9hbGxvY19vbmV8cHRlX2FsbG9jfF9fcHRlX2FsbG9jX2tlcm5l
bHxwdGVfYWxsb2Nfb25lX2tlcm5lbCkkIjsKCkkgc3VnZ2VzdCB0byBhZGp1c3QgdGhlIHJlZ3Vs
YXIgZXhwcmVzc2lvbiBmb3IgdGhpcyBjb25zdHJhaW50CmFuZCBpbiBzdWJzZXF1ZW50IFNtUEwg
cnVsZXMuCgoiXig/OnB0ZV9hbGxvYyg/Ol9vbmUoPzpfa2VybmVsKT8pP3xfX3B0ZV9hbGxvYyg/
Ol9rZXJuZWwpPykkIjsKCgo+ICgKPiAtIFQzIGZuKFQxIEUxLCBUMiBFMik7Cj4gKyBUMyBmbihU
MSBFMSk7Cj4gfAo+IC0gVDMgZm4oVDEgRTEsIFQyIEUyLCBUNCBFNCk7Cj4gKyBUMyBmbihUMSBF
MSwgVDIgRTIpOwo+ICkKCkkgcHJvcG9zZSB0byB0YWtlIGFuIG90aGVyIFNtUEwgZGlzanVuY3Rp
b24gaW50byBhY2NvdW50IGhlcmUuCgogVDMgZm4oVDEgRTEsCigKLSAgICAgIFQyIEUyCnwgICAg
ICBUMiBFMiwKLSAgICAgIFQ0IEU0CikgICAgICApOwoKCj4gKAo+IC0gI2RlZmluZSBmbihhLCBi
LCBjKUBwIGUKPiArICNkZWZpbmUgZm4oYSwgYikgZQo+IHwKPiAtICNkZWZpbmUgZm4oYSwgYilA
cCBlCj4gKyAjZGVmaW5lIGZuKGEpIGUKPiApCgpIb3cgZG8geW91IHRoaW5rIGFib3V0IHRvIG9t
aXQgdGhlIG1ldGF2YXJpYWJsZSDigJxwb3NpdGlvbiBw4oCdIGhlcmU/CgpSZWdhcmRzLApNYXJr
dXMKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4
LXNucHMtYXJjIG1haWxpbmcgbGlzdApsaW51eC1zbnBzLWFyY0BsaXN0cy5pbmZyYWRlYWQub3Jn
Cmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtc25wcy1h
cmM=
