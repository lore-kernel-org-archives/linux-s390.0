From: Chen Gang <gang.chen@asianux.com>
Subject: Re: [PATCH v2] arch: s390: appldata: using strncpy() and strnlen()
 instead of sprintf()
Date: Wed, 29 May 2013 09:40:55 +0800
Message-ID: <51A55CA7.4040703@asianux.com>
References: <51A48EE9.2040401@asianux.com> <51A32D81.2010105@asianux.com> <51A2CC07.5010100@asianux.com> <CAMuHMdXTW3QOxfAfqQXdbSpP4R83srFf7eMfu5fA-75S_Mujsg@mail.gmail.com> <4310.1369736553@warthog.procyon.org.uk> <5895.1369743429@warthog.procyon.org.uk> <20130528180327.6e6171f0@thinkpad>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
In-Reply-To: <20130528180327.6e6171f0@thinkpad>
Sender: linux-arch-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: Gerald Schaefer <gerald.schaefer@de.ibm.com>
Cc: David Howells <dhowells@redhat.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux390@de.ibm.com, linux-s390@vger.kernel.org, Linux-Arch <linux-arch@vger.kernel.org>, "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>, wharms@bfs.de
List-ID: <linux-s390.vger.kernel.org>

On 05/29/2013 12:03 AM, Gerald Schaefer wrote:
> On Tue, 28 May 2013 13:17:09 +0100
> David Howells <dhowells@redhat.com> wrote:
> 
>> > Chen Gang <gang.chen@asianux.com> wrote:
>> > 
>>> > > Your suggestion will improve the speed, but may merge "transferring
>>> > > 'protocol' data" and "processing 'protocol' data" together.
>> > 
>> > Look at it this way: You're having to step very carefully because you are
>> > fully expecting the strings not to be NUL-terminated.  Therefore you probably
>> > avoid using string functions if you can.
>> > 
>> > In fact, looking at the code, why are you copying the data through an
>> > intermediate buffer at all?  Why not just copy directly to userspace:
>> > 
>> > 	int len;
>> > 	char buf[2];
>> > 
>> > 	if (!*lenp || *ppos) {
>> > 		*lenp = 0;
>> > 		return 0;
>> > 	}
>> > 	if (!write) {
>> > -		len = sprintf(buf, appldata_timer_active ? "1\n" : "0\n");
>> > +		const char *ptr = appldata_timer_active ? "1\n" : "0\n";
>> > +		size_t len = 2;
>> > 		if (len > *lenp)
>> > 			len = *lenp;
>> > 		if (copy_to_user(buffer, buf, len))
>> > 			return -EFAULT;
>> > 		goto out;
>> > 	}
>> > 
>> > Put like that, it's fairly obvious what is going on.
> Yes, we could do that for !write, but we can't get rid of the buffer
> completely, as we need it for the other case and copy_from_user().
> I have already applied the v2 version from Chen Gang, as it fixes the
> overflow bug, and the affected code is not performance critical at all.
> I like the improved readability of your approach, but the patch is already
> on its way to Martins "for-linus" branch, and I think it's "good enough".
> 
> Thanks for all the feedback to this little piece of very old (and partly
> ugly) code from my very first Linux device driver :-)
> 

OK, thank you. and thank all related feedback from Geert, Walter, David


Thanks.
-- 
Chen Gang

Asianux Corporation
