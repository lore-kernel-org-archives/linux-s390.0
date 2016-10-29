From: Pan Xinhui <xinhui@linux.vnet.ibm.com>
Subject: Re: [Xen-devel] [PATCH v6 10/11] x86, xen: support vcpu preempted
	check
Date: Sat, 29 Oct 2016 12:26:30 +0800
Message-ID: <4afb98a9-9fb0-28e2-8d42-8bd6e3edeb9c@linux.vnet.ibm.com>
References: <1477642287-24104-1-git-send-email-xinhui.pan@linux.vnet.ibm.com>
	<1477642287-24104-11-git-send-email-xinhui.pan@linux.vnet.ibm.com>
	<20161028194325.GE2879@char.us.oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20161028194325.GE2879@char.us.oracle.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>
Cc: kvm@vger.kernel.org, rkrcmar@redhat.com, peterz@infradead.org, benh@kernel.crashing.org, will.deacon@arm.com, virtualization@lists.linux-foundation.org, paulus@samba.org, kernellwp@gmail.com, linux-s390@vger.kernel.org, xen-devel-request@lists.xenproject.org, x86@kernel.org, mingo@redhat.com, xen-devel@lists.xenproject.org, paulmck@linux.vnet.ibm.com, boqun.feng@gmail.com, jgross@suse.com, linux-kernel@vger.kernel.org, David.Laight@ACULAB.COM, mpe@ellerman.id.au, pbonzini@redhat.com, linuxppc-dev@lists.ozlabs.org
List-ID: <linux-s390.vger.kernel.org>

CgrlnKggMjAxNi8xMC8yOSAwMzo0MywgS29ucmFkIFJ6ZXN6dXRlayBXaWxrIOWGmemBkzoKPiBP
biBGcmksIE9jdCAyOCwgMjAxNiBhdCAwNDoxMToyNkFNIC0wNDAwLCBQYW4gWGluaHVpIHdyb3Rl
Ogo+PiBGcm9tOiBKdWVyZ2VuIEdyb3NzIDxqZ3Jvc3NAc3VzZS5jb20+Cj4+Cj4+IFN1cHBvcnQg
dGhlIHZjcHVfaXNfcHJlZW1wdGVkKCkgZnVuY3Rpb25hbGl0eSB1bmRlciBYZW4uIFRoaXMgd2ls
bAo+PiBlbmhhbmNlIGxvY2sgcGVyZm9ybWFuY2Ugb24gb3ZlcmNvbW1pdHRlZCBob3N0cyAobW9y
ZSBydW5uYWJsZSB2Y3B1cwo+PiB0aGFuIHBoeXNpY2FsIGNwdXMgaW4gdGhlIHN5c3RlbSkgYXMg
ZG9pbmcgYnVzeSB3YWl0cyBmb3IgcHJlZW1wdGVkCj4+IHZjcHVzIHdpbGwgaHVydCBzeXN0ZW0g
cGVyZm9ybWFuY2UgZmFyIHdvcnNlIHRoYW4gZWFybHkgeWllbGRpbmcuCj4+Cj4+IEEgcXVpY2sg
dGVzdCAoNCB2Y3B1cyBvbiAxIHBoeXNpY2FsIGNwdSBkb2luZyBhIHBhcmFsbGVsIGJ1aWxkIGpv
Ygo+PiB3aXRoICJtYWtlIC1qIDgiKSByZWR1Y2VkIHN5c3RlbSB0aW1lIGJ5IGFib3V0IDUlIHdp
dGggdGhpcyBwYXRjaC4KPj4KPj4gU2lnbmVkLW9mZi1ieTogSnVlcmdlbiBHcm9zcyA8amdyb3Nz
QHN1c2UuY29tPgo+PiBTaWduZWQtb2ZmLWJ5OiBQYW4gWGluaHVpIDx4aW5odWkucGFuQGxpbnV4
LnZuZXQuaWJtLmNvbT4KPj4gLS0tCj4+ICBhcmNoL3g4Ni94ZW4vc3BpbmxvY2suYyB8IDMgKyst
Cj4+ICAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pCj4+Cj4+
IGRpZmYgLS1naXQgYS9hcmNoL3g4Ni94ZW4vc3BpbmxvY2suYyBiL2FyY2gveDg2L3hlbi9zcGlu
bG9jay5jCj4+IGluZGV4IDNkNmUwMDYuLjc0NzU2YmIgMTAwNjQ0Cj4+IC0tLSBhL2FyY2gveDg2
L3hlbi9zcGlubG9jay5jCj4+ICsrKyBiL2FyY2gveDg2L3hlbi9zcGlubG9jay5jCj4+IEBAIC0x
MTQsNyArMTE0LDYgQEAgdm9pZCB4ZW5fdW5pbml0X2xvY2tfY3B1KGludCBjcHUpCj4+ICAJcGVy
X2NwdShpcnFfbmFtZSwgY3B1KSA9IE5VTEw7Cj4+ICB9Cj4+Cj4+IC0KPgo+IFNwdXJpb3VzIGNo
YW5nZS4Kd2VsbCwganVzdCByZW1vdmUgb25lIHVubmVjZXNzYXJ5IGJsYW5rIGxpbmUgd2hpbGUg
YXQgaXQuCgo+PiAgLyoKPj4gICAqIE91ciBpbml0IG9mIFBWIHNwaW5sb2NrcyBpcyBzcGxpdCBp
biB0d28gaW5pdCBmdW5jdGlvbnMgZHVlIHRvIHVzCj4+ICAgKiB1c2luZyBwYXJhdmlydCBwYXRj
aGluZyBhbmQganVtcCBsYWJlbHMgcGF0Y2hpbmcgYW5kIGhhdmluZyB0byBkbwo+PiBAQCAtMTM3
LDYgKzEzNiw4IEBAIHZvaWQgX19pbml0IHhlbl9pbml0X3NwaW5sb2Nrcyh2b2lkKQo+PiAgCXB2
X2xvY2tfb3BzLnF1ZXVlZF9zcGluX3VubG9jayA9IFBWX0NBTExFRV9TQVZFKF9fcHZfcXVldWVk
X3NwaW5fdW5sb2NrKTsKPj4gIAlwdl9sb2NrX29wcy53YWl0ID0geGVuX3Fsb2NrX3dhaXQ7Cj4+
ICAJcHZfbG9ja19vcHMua2ljayA9IHhlbl9xbG9ja19raWNrOwo+PiArCj4+ICsJcHZfbG9ja19v
cHMudmNwdV9pc19wcmVlbXB0ZWQgPSB4ZW5fdmNwdV9zdG9sZW47Cj4+ICB9Cj4+Cj4+ICAvKgo+
PiAtLQo+PiAyLjQuMTEKPj4KPj4KPj4gX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX18KPj4gWGVuLWRldmVsIG1haWxpbmcgbGlzdAo+PiBYZW4tZGV2ZWxAbGlz
dHMueGVuLm9yZwo+PiBodHRwczovL2xpc3RzLnhlbi5vcmcveGVuLWRldmVsCj4KCl9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1h
aWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRw
czovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXph
dGlvbg==
