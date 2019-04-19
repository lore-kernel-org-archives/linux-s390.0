From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH v2 05/11] mtd: rawnand: vf610_nfc: add initializer to avoid
 -Wmaybe-uninitialized
Date: Fri, 19 Apr 2019 18:47:48 +0900
Message-ID: <20190419094754.24667-6-yamada.masahiro@socionext.com>
References: <20190419094754.24667-1-yamada.masahiro@socionext.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20190419094754.24667-1-yamada.masahiro@socionext.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>, linux-arch <linux-arch@vger.kernel.org>
Cc: Christophe Leroy <christophe.leroy@c-s.fr>, linux-s390@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, x86@kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org, Masahiro Yamada <yamada.masahiro@socionext.com>, Ingo Molnar <mingo@redhat.com>, linux-mtd@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
List-ID: <linux-s390.vger.kernel.org>

VGhpcyBwcmVwYXJlcyB0byBtb3ZlIENPTkZJR19PUFRJTUlaRV9JTkxJTklORyBmcm9tIHg4NiB0
byBhIGNvbW1vbgpwbGFjZS4gV2UgbmVlZCB0byBlbGltaW5hdGUgcG90ZW50aWFsIGlzc3VlcyBi
ZWZvcmVoYW5kLgoKS2J1aWxkIHRlc3Qgcm9ib3QgaGFzIG5ldmVyIHJlcG9ydGVkIC1XbWF5YmUt
dW5pbml0aWFsaXplZCB3YXJuaW5nCmZvciB0aGlzIHByb2JhYmx5IGJlY2F1c2UgdmY2MTBfbmZj
X3J1bigpIGlzIGlubGluZWQgYnkgdGhlIHg4Ngpjb21waWxlcidzIGlubGluaW5nIGhldXJpc3Rp
Yy4KCklmIENPTkZJR19PUFRJTUlaRV9JTkxJTklORyBpcyBlbmFibGVkIGZvciBhIGRpZmZlcmVu
dCBhcmNoaXRlY3R1cmUKYW5kIHZmNjEwX25mY19ydW4oKSBpcyBub3QgaW5saW5lZCwgdGhlIGZv
bGxvd2luZyB3YXJuaW5nIGlzIHJlcG9ydGVkOgoKZHJpdmVycy9tdGQvbmFuZC9yYXcvdmY2MTBf
bmZjLmM6IEluIGZ1bmN0aW9uIOKAmHZmNjEwX25mY19jbWTigJk6CmRyaXZlcnMvbXRkL25hbmQv
cmF3L3ZmNjEwX25mYy5jOjQ1NTozOiB3YXJuaW5nOiDigJhvZmZzZXTigJkgbWF5IGJlIHVzZWQg
dW5pbml0aWFsaXplZCBpbiB0aGlzIGZ1bmN0aW9uIFstV21heWJlLXVuaW5pdGlhbGl6ZWRdCiAg
IHZmNjEwX25mY19yZF9mcm9tX3NyYW0oaW5zdHItPmN0eC5kYXRhLmJ1Zi5pbiArIG9mZnNldCwK
ICAgXn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+
fgogICAgICAgICAgICBuZmMtPnJlZ3MgKyBORkNfTUFJTl9BUkVBKDApICsgb2Zmc2V0LAogICAg
ICAgICAgICB+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fgogICAgICAgICAg
ICB0cmZyX3N6LCAhbmZjLT5kYXRhX2FjY2Vzcyk7CiAgICAgICAgICAgIH5+fn5+fn5+fn5+fn5+
fn5+fn5+fn5+fn5+fgoKU2lnbmVkLW9mZi1ieTogTWFzYWhpcm8gWWFtYWRhIDx5YW1hZGEubWFz
YWhpcm9Ac29jaW9uZXh0LmNvbT4KLS0tCgpDaGFuZ2VzIGluIHYyOgogIC0gc3BsaXQgaW50byBh
IHNlcGFyYXRlIHBhdGNoCgogZHJpdmVycy9tdGQvbmFuZC9yYXcvdmY2MTBfbmZjLmMgfCAyICst
CiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkKCmRpZmYgLS1n
aXQgYS9kcml2ZXJzL210ZC9uYW5kL3Jhdy92ZjYxMF9uZmMuYyBiL2RyaXZlcnMvbXRkL25hbmQv
cmF3L3ZmNjEwX25mYy5jCmluZGV4IGE2NjJjYTE5NzBlNS4uMTk3OTJkNzI1ZWMyIDEwMDY0NAot
LS0gYS9kcml2ZXJzL210ZC9uYW5kL3Jhdy92ZjYxMF9uZmMuYworKysgYi9kcml2ZXJzL210ZC9u
YW5kL3Jhdy92ZjYxMF9uZmMuYwpAQCAtMzY0LDcgKzM2NCw3IEBAIHN0YXRpYyBpbnQgdmY2MTBf
bmZjX2NtZChzdHJ1Y3QgbmFuZF9jaGlwICpjaGlwLAogewogCWNvbnN0IHN0cnVjdCBuYW5kX29w
X2luc3RyICppbnN0cjsKIAlzdHJ1Y3QgdmY2MTBfbmZjICpuZmMgPSBjaGlwX3RvX25mYyhjaGlw
KTsKLQlpbnQgb3BfaWQgPSAtMSwgdHJmcl9zeiA9IDAsIG9mZnNldDsKKwlpbnQgb3BfaWQgPSAt
MSwgdHJmcl9zeiA9IDAsIG9mZnNldCA9IDA7CiAJdTMyIGNvbCA9IDAsIHJvdyA9IDAsIGNtZDEg
PSAwLCBjbWQyID0gMCwgY29kZSA9IDA7CiAJYm9vbCBmb3JjZThiaXQgPSBmYWxzZTsKIAotLSAK
Mi4xNy4xCgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18K
bGludXgtYXJtLWtlcm5lbCBtYWlsaW5nIGxpc3QKbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZy
YWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGlu
dXgtYXJtLWtlcm5lbAo=
