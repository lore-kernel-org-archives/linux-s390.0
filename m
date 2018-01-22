From: Eugene Syromyatnikov <evgsyr@gmail.com>
Date: Mon, 22 Jan 2018 13:19:20 +0000
Subject: Re: [man-pages PATCH 4/5] s390_sthyi.2: some minor additions
Message-Id: <CACGkJdto1aTDRr78F4CY6M_4b94ZYu28mBMnDc+-u=9xP8_P_Q@mail.gmail.com>
In-Reply-To: <20180120120121.GD6287@osiris>
References: <20180120120121.GD6287@osiris>
To: linux-s390@vger.kernel.org, linux-man@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Sat, Jan 20, 2018 at 12:01 PM, Heiko Carstens
<heiko.carstens@de.ibm.com> wrote:
> On Sun, Jan 14, 2018 at 07:56:39PM +0100, Eugene Syromyatnikov wrote:
>> * man2/s390_sthyi.2 (.SH DESCRIPTION): Document the size of the
>> resp_buffer when function_code is 0.
>> (.SH NOTES): Document various aspects of the current implementation (the
>> lifted requirement for the response buffer alignment, the usage of
>> hardware STHYI instruction whether available, the presence of in-kernel
>> cache), add description for the documentation URL.
>> ---
>> +The in-kernel implementation of the function code 0 doesn't require the response
>> +buffer to be aligned to a page boundary (in contrast to the STHYI instruction
>> +requirement).
>
> Maybe: "When using the system call interface the response buffer doesn't
> have to fulfill alignment requirements as described in the STHYI
> instruction defintion." ?

Yes, that sounds better.

>> +.PP
>> +The in-kernel implementation uses STHYI function whether available.
>> +.PP
>
> I don't think this should be described in the man page. This is an
> implementation detail that can change at any time.

Agreed.

>> +The kernel caches the response (for one second, currently), so the subsequent
>> +calls to the system call within may return previously cached values instead.
>
> "The kernel caches the response up to one second. Subsequent system call
> invocations may return the cached response." ?

Yep, that's definitely phrased better.

-- 
Eugene Syromyatnikov
mailto:evgsyr@gmail.com
xmpp:esyr@jabber.{ru|org}
