Return-Path: <SRS0=rc36=SS=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
MIME-Version: 1.0
References: <CAHk-=wjvcuyCQGnfOhooaL1H4H63qXO=xgo+9yncSOG=eK+kbA@mail.gmail.com>
 <20190415051919.GA31481@infradead.org>
 <CAHk-=wj7jgMOVFW0tiU-X+zhg6+Rn7mEBTej+f26rV3zXezOSA@mail.gmail.com>
 <20190416110906.6c773aff@mschwideX1> <20190416140658.2cb73a3f@mschwideX1>
 <CAHk-=wjKi5C+Onhp5Vs5BQxHbaBud9M3cTS-S6Tr9yDY4dS-Sw@mail.gmail.com>
In-Reply-To: <CAHk-=wjKi5C+Onhp5Vs5BQxHbaBud9M3cTS-S6Tr9yDY4dS-Sw@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 16 Apr 2019 09:49:46 -0700
Message-ID: <CAHk-=wj2SW0Zno0Yn=S9wrsmHOKV0FiFPiPS4TM=Gn8yjfYXAg@mail.gmail.com>
Subject: Re: Linux 5.1-rc5
Content-Type: multipart/mixed; boundary="0000000000006f45e80586a88f88"
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: Christoph Hellwig <hch@infradead.org>, linuxppc-dev@lists.ozlabs.org, Linux List Kernel Mailing <linux-kernel@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

--0000000000006f45e80586a88f88
Content-Type: text/plain; charset="UTF-8"

On Tue, Apr 16, 2019 at 9:16 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> We actually already *have* this function.
>
> It's called "gup_fast_permitted()" and it's used by x86-64 to verify
> the proper address range. Exactly like s390 needs..
>
> Could you please use that instead?

IOW, something like the attached.

Obviously untested. And maybe 'current' isn't declared in
<asm/pgtable.h>, in which case you'd need to modify it to instead make
the inline function be "s390_gup_fast_permitted()" that takes a
pointer to the mm, and do something like

  #define gup_fast_permitted(start, pages) \
         s390_gup_fast_permitted(current->mm, start, pages)

instead.

But I think you get the idea..

                Linus

--0000000000006f45e80586a88f88
Content-Type: text/x-patch; charset="US-ASCII"; name="patch.diff"
Content-Disposition: attachment; filename="patch.diff"
Content-Transfer-Encoding: base64
Content-ID: <f_juk0utdu0>
X-Attachment-Id: f_juk0utdu0

IGFyY2gvczM5MC9pbmNsdWRlL2FzbS9wZ3RhYmxlLmggfCAxMiArKysrKysrKysrKysKIDEgZmls
ZSBjaGFuZ2VkLCAxMiBpbnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0IGEvYXJjaC9zMzkwL2luY2x1
ZGUvYXNtL3BndGFibGUuaCBiL2FyY2gvczM5MC9pbmNsdWRlL2FzbS9wZ3RhYmxlLmgKaW5kZXgg
NzZkYzM0NGVkYjhjLi5hMDgyNDg5OTVmNTAgMTAwNjQ0Ci0tLSBhL2FyY2gvczM5MC9pbmNsdWRl
L2FzbS9wZ3RhYmxlLmgKKysrIGIvYXJjaC9zMzkwL2luY2x1ZGUvYXNtL3BndGFibGUuaApAQCAt
MTY1OSw0ICsxNjU5LDE2IEBAIHN0YXRpYyBpbmxpbmUgdm9pZCBjaGVja19wZ3RfY2FjaGUodm9p
ZCkgeyB9CiAKICNpbmNsdWRlIDxhc20tZ2VuZXJpYy9wZ3RhYmxlLmg+CiAKK3N0YXRpYyBpbmxp
bmUgYm9vbCBndXBfZmFzdF9wZXJtaXR0ZWQodW5zaWduZWQgbG9uZyBzdGFydCwgaW50IG5yX3Bh
Z2VzKQoreworCXVuc2lnbmVkIGxvbmcgbGVuLCBlbmQ7CisKKwlsZW4gPSAodW5zaWduZWQgbG9u
Zylucl9wYWdlcyA8PCBQQUdFX1NISUZUOworCWVuZCA9IHN0YXJ0ICsgbGVuOworCWlmIChlbmQg
PCBzdGFydCkKKwkJcmV0dXJuIGZhbHNlOworCXJldHVybiBlbmQgPD0gY3VycmVudC0+bW0tPmNv
bnRleHQuYXNjZV9saW1pdDsKK30KKyNkZWZpbmUgZ3VwX2Zhc3RfcGVybWl0dGVkIGd1cF9mYXN0
X3Blcm1pdHRlZAorCiAjZW5kaWYgLyogX1MzOTBfUEFHRV9IICovCg==
--0000000000006f45e80586a88f88--
