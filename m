From: Masami Hiramatsu <mhiramat@kernel.org>
Date: Wed, 30 Jan 2019 15:34:56 +0000
Subject: Re: kprobe string arg does not return proper value
Message-Id: <20190131003456.95069cd7db3207313ee0b93a@kernel.org>
In-Reply-To: <20190130212113.39aed8a13ddb7c5835753550@kernel.org>
References: <20190130212113.39aed8a13ddb7c5835753550@kernel.org>
To: linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Tue, 29 Jan 2019 16:53:27 +0100
Heiko Carstens <heiko.carstens@de.ibm.com> wrote:

> > > And if I'm correct it is not easy to "fix". _If_ this functionality is
> > > desired then the kprobes interface must probably be changed so that it
> > > would be possible to specify the address space from where something
> > > should be copied. Or.. maybe the "__user" annotation in the kernel
> > > code can be instrumented(?).
> > 
> > No, I don't want to "fix" this. Describing in a document will be OK,
> > but this is a limitation comes from its design.
> 
> It could be fixed if e.g. a new ustring fetcharg type would be
> supported, where we don't switch to KERNEL_DS. It would still fault
> when the page isn't mapped, but would access the correct address
> space.

Ah, I got it, so the user space will be mapped somewhere.

> I don't know if it is really worth to implement this.. since I'm
> afraid this will cause "some" problems ;)

If someone (who can work on s390) is interested in, feel free to expand
string copy function, but I don't like introducing "ustring", since it is
highly depending on arch and anyway we can not guarantee to fetch the string
when the page is not mapped..

Thank you,

-- 
Masami Hiramatsu <mhiramat@kernel.org>
