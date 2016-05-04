Return-Path: <David.Laight@ACULAB.COM>
From: David Laight <David.Laight@ACULAB.COM>
Subject: RE: [RFC PATCH v2 05/18] sched: add task flag for preempt IRQ tracking
Date: Wed, 4 May 2016 15:16:31 +0000
Message-ID: <063D6719AE5E284EB5DD2968C1650D6D5F4B45CB@AcuExch.aculab.com>
References: <20160429201139.pudoged2yathyo64@treble>
 <CALCETrW8G8qCHBkH7GFDTFuH82abJpbVq_-bDaRAdL7U0jLGNQ@mail.gmail.com>
 <20160429202701.yijrohqdsurdxv2a@treble>
 <CALCETrVKt8k11ewSOvGiCNsqgtD5cMaLix8Tf8JJakgodJeLyA@mail.gmail.com>
 <20160429212546.t26mvthtvh7543ff@treble>
 <CALCETrV2wtsEZH-OEDDGzYK-s02EeCWq1MZsYbrdjfyrbU7ugw@mail.gmail.com>
 <20160429224112.kl3jlk7ccvfceg2r@treble>
 <CALCETrUvRKYpF5MuhYuHSxd1QFnzSNKdXUQp+3to6rzKzQjQSw@mail.gmail.com>
 <20160502135243.jkbnonaesv7zfios@treble>
 <CALCETrWc5VFyo9tE5fQGKfijqCjguSSci71HSe58Z1_AL1ZHmQ@mail.gmail.com>
 <20160502173148.zsg6alhknczzozb5@treble>
 <CALCETrUwHc5G37hoNKou3nBO+5RjenOJqXYR4yGaj9yCZwXbZA@mail.gmail.com>
In-Reply-To: <CALCETrUwHc5G37hoNKou3nBO+5RjenOJqXYR4yGaj9yCZwXbZA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>
To: 'Andy Lutomirski' <luto@amacapital.net>, Josh Poimboeuf <jpoimboe@redhat.com>
Cc: "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>, Jiri Kosina <jikos@kernel.org>, Jessica Yu <jeyu@redhat.com>, Vojtech Pavlik <vojtech@suse.com>, Petr Mladek <pmladek@suse.com>, Peter Zijlstra <peterz@infradead.org>, X86 ML <x86@kernel.org>, Heiko Carstens <heiko.carstens@de.ibm.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>, "live-patching@vger.kernel.org" <live-patching@vger.kernel.org>, Jiri Slaby <jslaby@suse.cz>, Miroslav Benes <mbenes@suse.cz>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, Chris J
 Arges <chris.j.arges@canonical.com>
List-ID: <linux-s390.vger.kernel.org>

RnJvbTogQW5keSBMdXRvbWlyc2tpDQo+IFNlbnQ6IDAyIE1heSAyMDE2IDE5OjEzDQouLi4NCj4g
SSBob3BlIHlvdXIgcGxhbnMgaW5jbHVkZSByZXdyaXRpbmcgdGhlIGN1cnJlbnQgc3RhY2sgdW53
aW5kZXINCj4gY29tcGxldGVseS4gIFRoZSB0aGluZyBpbiBwcmludF9jb250ZXh0X3N0YWNrIGlz
IChhKQ0KPiBoYXJkLXRvLXVuZGVyc3RhbmQgYW5kIGhhcmQtdG8tbW9kaWZ5IGNyYXAgYW5kIChi
KSBpcyBjYWxsZWQgaW4gYSBsb29wDQo+IGZyb20gYW5vdGhlciBmaWxlIHVzaW5nIHRvdGFsbHkg
cmlkaWN1bG91cyBjb252ZW50aW9ucy4NCg0KSSd2ZSBzZWVuIGEgJ3N0YWNrIHVud2luZGVyJyB0
aGF0IHBhcnNlZCB0aGUgaW5zdHJ1Y3Rpb24gc3RyZWFtDQpmb3J3YXJkcyBsb29raW5nIGZvciAn
cmV0dXJuJyBpbnN0cnVjdGlvbnMuDQpJIGZpeGVkIGl0IHRvIGFkZCBhIGZldyBleHRyYSBpbnN0
cnVjdGlvbnMgbmVlZHMgdG8gc29ydCBvdXQgdGhlDQpleGl0IHBhdGggZnJvbSBoYXJkd2FyZSBp
bnRlcnJ1cHRzLg0KDQpJdCBvbmx5IGhhZCB0byB1bmRlcnN0YW5kIGluc3RydWN0aW9ucyB0aGF0
IG1vZGlmaWVkICVzcCBhbmQgJWJwDQphbmQgcmVtZW1iZXIgd2hpY2ggYnJhbmNoIGluc3RydWN0
aW9ucyBhbmQgYnJhbmNoIHRhcmdldHMgaXQgaGFkDQp1c2VkIGluIG9yZGVyIHRvIGZpbmQgdGhl
IGNvcnJlY3QgZXhpdCBwYXRoIGZyb20gYSBmdW5jdGlvbi4NCg0KV29ya2VkIHJlYXNvbmFibHkg
d2VsbCB3aXRob3V0IGFueSBkZWJ1ZyBpbmZvIG9yIGd1YXJhbnRlZWQgZnJhbWUNCnBvaW50ZXJz
Lg0KSXQgZGlkIGhhdmUgdG8gZmFsbCBiYWNrIG9uIHNjYW5uaW5nIHRoZSBzdGFjayBpZiBpdCB3
YXMgaW5zaWRlDQphbiBpbmZpbml0ZSBsb29wLiBFdmVuIG9uIHg4NiBpdCBpcyByZWFzb25hYmx5
IHBvc3NpYmxlIHRvIGNoZWNrDQpmb3IgJ2NhbGwnIGluc3RydWN0aW9ucyBpbiB0aGlzIGNhc2Uu
DQoNCglEYXZpZA0KDQo=
