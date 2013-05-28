From: Chen Gang <gang.chen@asianux.com>
Subject: Re: [PATCH v2] arch: s390: appldata: using strncpy() and strnlen()
 instead of sprintf()
Date: Tue, 28 May 2013 19:03:05 +0800
Message-ID: <51A48EE9.2040401@asianux.com>
References: <51A32D81.2010105@asianux.com> <51A2CC07.5010100@asianux.com> <CAMuHMdXTW3QOxfAfqQXdbSpP4R83srFf7eMfu5fA-75S_Mujsg@mail.gmail.com> <4310.1369736553@warthog.procyon.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
In-Reply-To: <4310.1369736553@warthog.procyon.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, jang@linux.vnet.ibm.com, linux390@de.ibm.com, linux-s390@vger.kernel.org, Linux-Arch <linux-arch@vger.kernel.org>, "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

On 05/28/2013 06:22 PM, David Howells wrote:
> Chen Gang <gang.chen@asianux.com> wrote:
> 
>> > -		len = sprintf(buf, appldata_timer_active ? "1\n" : "0\n");
>> > +		strncpy(buf, appldata_timer_active ? "1\n" : "0\n",
>> > +			ARRAY_SIZE(buf));
>> > +		len = strnlen(buf, ARRAY_SIZE(buf));
> Since the strings here are a fixed, preknown size, you should use memcpy (or
> just fill in the array directly which would likely take fewer instructions
> since the strings are so short and vary by one character) and hard-code the
> length or use sizeof() instead of strnlen().

I treat it "?\n" as a 'protocol' between kernel mode and user mode, the
original issue is about transferring 'protocol' data. the patch wants to
fix the issue, independent of 'protocol'.

appldata_timer_handler() itself has already separated "transferring
'protocol' data" from "processing 'protocol' data" (but not let the
"processing 'protocol' data" in another new function)

Your suggestion will improve the speed, but may merge "transferring
'protocol' data" and "processing 'protocol' data" together.

So if the performance is not quite important in this location, it is
still reasonable to follow with the original author's willing
(especially what he/she has done sounds reasonable too).


Thanks.
-- 
Chen Gang

Asianux Corporation
