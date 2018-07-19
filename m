Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
Subject: Re: [PATCH v14 20/25] x86/tsc: calibrate tsc only once
References: <20180718022211.6259-1-pasha.tatashin@oracle.com>
 <20180718022211.6259-21-pasha.tatashin@oracle.com>
 <4f0933a3-27b4-5468-83f5-af9b90842812@cn.fujitsu.com>
 <alpine.DEB.2.21.1807190818110.1689@nanos.tec.linutronix.de>
From: Dou Liyang <douly.fnst@cn.fujitsu.com>
Message-ID: <82b363bb-de81-0ddf-cb0d-83945eba72f0@cn.fujitsu.com>
Date: Thu, 19 Jul 2018 14:48:28 +0800
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1807190818110.1689@nanos.tec.linutronix.de>
Content-Type: text/plain; charset="gbk"; format="flowed"
Content-Language: en-US
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Pavel Tatashin <pasha.tatashin@oracle.com>, steven.sistare@oracle.com, daniel.m.jordan@oracle.com, linux@armlinux.org.uk, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, john.stultz@linaro.org, sboyd@codeaurora.org, x86@kernel.org, linux-kernel@vger.kernel.org, mingo@redhat.com, hpa@zytor.com, peterz@infradead.org, prarit@redhat.com, feng.tang@intel.com, pmladek@suse.com, gnomes@lxorguk.ukuu.org.uk, linux-s390@vger.kernel.org, boris.ostrovsky@oracle.com, jgross@suse.com, pbonzini@redhat.com
List-ID: <linux-s390.vger.kernel.org>

SGkgVGhvbWFzLAoKQXQgMDcvMTkvMjAxOCAwMjoyNSBQTSwgVGhvbWFzIEdsZWl4bmVyIHdyb3Rl
Ogo+IE9uIFRodSwgMTkgSnVsIDIwMTgsIERvdSBMaXlhbmcgd3JvdGU6Cj4+IEF0IDA3LzE4LzIw
MTggMTA6MjIgQU0sIFBhdmVsIFRhdGFzaGluIHdyb3RlOgo+Pj4gKwkJKHVuc2lnbmVkIGxvbmcp
Y3B1X2toeiAlIEtIWik7Cj4+PiAgICAgIAlpZiAoY3B1X2toeiAhPSB0c2Nfa2h6KSB7Cj4+PiAg
ICAJCXByX2luZm8oIkRldGVjdGVkICVsdS4lMDNsdSBNSHogVFNDIiwKPj4+IC0JCQkodW5zaWdu
ZWQgbG9uZyl0c2Nfa2h6IC8gMTAwMCwKPj4+IC0JCQkodW5zaWduZWQgbG9uZyl0c2Nfa2h6ICUg
MTAwMCk7Cj4+PiArCQkJKHVuc2lnbmVkIGxvbmcpdHNjX2toeiAvIEtIWiwKPj4+ICsJCQkodW5z
aWduZWQgbG9uZyl0c2Nfa2h6ICUgS0haKTsKPj4+ICsJfQo+Pgo+PiB0aGlzIGN1cmx5IGJyYWNr
ZXRzIGNhbiBiZSByZW1vdmVkCj4gCj4gTm8uIFRoZXkgd2FudCB0byBzdGF5LCByZWFsbHkuCj4g
Cj4gICAgICBodHRwczovL2xrbWwua2VybmVsLm9yZy9yL2FscGluZS5ERUIuMi4yMC4xNzAxMTcx
OTU2MjkwLjM2NDVAbmFub3MKPiAKPiBUaGUgcHJfaW5mbygpIGlzIGEgbXVsdGlsaW5lIHN0YXRl
bWVudCBkdWUgdG8gdGhlIGxpbmUgYnJlYWtzLgo+IAoKSSBzZWUsIEmhr2xsIGtlZXAgdGhhdCBp
biBtaW5kLgoKVGhhbmtzLAoKCWRvdQoKCg==
