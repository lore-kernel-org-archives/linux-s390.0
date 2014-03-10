From: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Subject: [PATCH v3 11/52] s390,
 cacheinfo: Fix CPU hotplug callback registration
Date: Tue, 11 Mar 2014 02:05:46 +0530
Message-ID: <20140310203545.10746.78648.stgit@srivatsabhat.in.ibm.com>
References: <20140310203312.10746.310.stgit@srivatsabhat.in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
In-Reply-To: <20140310203312.10746.310.stgit@srivatsabhat.in.ibm.com>
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
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: paulus@samba.org, oleg@redhat.com, rjw@rjwysocki.net, rusty@rustcorp.com.au, peterz@infradead.org, tglx@linutronix.de, akpm@linux-foundation.org
Cc: linux-arch@vger.kernel.org, ego@linux.vnet.ibm.com, walken@google.com, linux@arm.linux.org.uk, linux-pm@vger.kernel.org, linux-s390@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>, linuxppc-dev@ozlabs.org, "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>, tj@kernel.org, paulmck@linux.vnet.ibm.com, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

U3Vic3lzdGVtcyB0aGF0IHdhbnQgdG8gcmVnaXN0ZXIgQ1BVIGhvdHBsdWcgY2FsbGJhY2tzLCBh
cyB3ZWxsIGFzIHBlcmZvcm0KaW5pdGlhbGl6YXRpb24gZm9yIHRoZSBDUFVzIHRoYXQgYXJlIGFs
cmVhZHkgb25saW5lLCBvZnRlbiBkbyBpdCBhcyBzaG93bgpiZWxvdzoKCglnZXRfb25saW5lX2Nw
dXMoKTsKCglmb3JfZWFjaF9vbmxpbmVfY3B1KGNwdSkKCQlpbml0X2NwdShjcHUpOwoKCXJlZ2lz
dGVyX2NwdV9ub3RpZmllcigmZm9vYmFyX2NwdV9ub3RpZmllcik7CgoJcHV0X29ubGluZV9jcHVz
KCk7CgpUaGlzIGlzIHdyb25nLCBzaW5jZSBpdCBpcyBwcm9uZSB0byBBQkJBIGRlYWRsb2NrcyBp
bnZvbHZpbmcgdGhlCmNwdV9hZGRfcmVtb3ZlX2xvY2sgYW5kIHRoZSBjcHVfaG90cGx1Zy5sb2Nr
ICh3aGVuIHJ1bm5pbmcgY29uY3VycmVudGx5CndpdGggQ1BVIGhvdHBsdWcgb3BlcmF0aW9ucyku
CgpJbnN0ZWFkLCB0aGUgY29ycmVjdCBhbmQgcmFjZS1mcmVlIHdheSBvZiBwZXJmb3JtaW5nIHRo
ZSBjYWxsYmFjawpyZWdpc3RyYXRpb24gaXM6CgoJY3B1X25vdGlmaWVyX3JlZ2lzdGVyX2JlZ2lu
KCk7CgoJZm9yX2VhY2hfb25saW5lX2NwdShjcHUpCgkJaW5pdF9jcHUoY3B1KTsKCgkvKiBOb3Rl
IHRoZSB1c2Ugb2YgdGhlIGRvdWJsZSB1bmRlcnNjb3JlZCB2ZXJzaW9uIG9mIHRoZSBBUEkgKi8K
CV9fcmVnaXN0ZXJfY3B1X25vdGlmaWVyKCZmb29iYXJfY3B1X25vdGlmaWVyKTsKCgljcHVfbm90
aWZpZXJfcmVnaXN0ZXJfZG9uZSgpOwoKCkZpeCB0aGUgY2FjaGVpbmZvIGNvZGUgaW4gczM5MCBi
eSB1c2luZyB0aGlzIGxhdHRlciBmb3JtIG9mIGNhbGxiYWNrCnJlZ2lzdHJhdGlvbi4KCkNjOiBN
YXJ0aW4gU2Nod2lkZWZza3kgPHNjaHdpZGVmc2t5QGRlLmlibS5jb20+CkNjOiBIZWlrbyBDYXJz
dGVucyA8aGVpa28uY2Fyc3RlbnNAZGUuaWJtLmNvbT4KQ2M6IEluZ28gTW9sbmFyIDxtaW5nb0Br
ZXJuZWwub3JnPgpDYzogbGludXgtczM5MEB2Z2VyLmtlcm5lbC5vcmcKU2lnbmVkLW9mZi1ieTog
U3JpdmF0c2EgUy4gQmhhdCA8c3JpdmF0c2EuYmhhdEBsaW51eC52bmV0LmlibS5jb20+Ci0tLQoK
IGFyY2gvczM5MC9rZXJuZWwvY2FjaGUuYyB8ICAgIDUgKysrKy0KIDEgZmlsZSBjaGFuZ2VkLCA0
IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkKCmRpZmYgLS1naXQgYS9hcmNoL3MzOTAva2Vy
bmVsL2NhY2hlLmMgYi9hcmNoL3MzOTAva2VybmVsL2NhY2hlLmMKaW5kZXggM2E0MTRjMC4uYzBi
MDNjMiAxMDA2NDQKLS0tIGEvYXJjaC9zMzkwL2tlcm5lbC9jYWNoZS5jCisrKyBiL2FyY2gvczM5
MC9rZXJuZWwvY2FjaGUuYwpAQCAtMzc4LDkgKzM3OCwxMiBAQCBzdGF0aWMgaW50IF9faW5pdCBj
YWNoZV9pbml0KHZvaWQpCiAJaWYgKCF0ZXN0X2ZhY2lsaXR5KDM0KSkKIAkJcmV0dXJuIDA7CiAJ
Y2FjaGVfYnVpbGRfaW5mbygpOworCisJY3B1X25vdGlmaWVyX3JlZ2lzdGVyX2JlZ2luKCk7CiAJ
Zm9yX2VhY2hfb25saW5lX2NwdShjcHUpCiAJCWNhY2hlX2FkZF9jcHUoY3B1KTsKLQlob3RjcHVf
bm90aWZpZXIoY2FjaGVfaG90cGx1ZywgMCk7CisJX19ob3RjcHVfbm90aWZpZXIoY2FjaGVfaG90
cGx1ZywgMCk7CisJY3B1X25vdGlmaWVyX3JlZ2lzdGVyX2RvbmUoKTsKIAlyZXR1cm4gMDsKIH0K
IGRldmljZV9pbml0Y2FsbChjYWNoZV9pbml0KTsKCl9fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fCkxpbnV4cHBjLWRldiBtYWlsaW5nIGxpc3QKTGludXhwcGMt
ZGV2QGxpc3RzLm96bGFicy5vcmcKaHR0cHM6Ly9saXN0cy5vemxhYnMub3JnL2xpc3RpbmZvL2xp
bnV4cHBjLWRldg==
