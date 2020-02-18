Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:12624 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726323AbgBRJiA (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 18 Feb 2020 04:38:00 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01I9TKZ8057913
        for <linux-s390@vger.kernel.org>; Tue, 18 Feb 2020 04:37:59 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2y85f3emcr-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Tue, 18 Feb 2020 04:37:58 -0500
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <prudo@linux.ibm.com>;
        Tue, 18 Feb 2020 09:37:57 -0000
Date: Tue, 18 Feb 2020 10:37:52 +0100
From: Philipp Rudo <prudo@linux.ibm.com>
Subject: Re: s390 depending on cc-options makes it difficult to configure
In-Reply-To: <20200216185759.GA4091960@dev.jcline.org>
References: <20191209164155.GA78160@dev.jcline.org>
        <20191210090108.GA22512@unicorn.suse.cz>
        <20191211171822.GA36366@dev.jcline.org>
        <20200210194936.511ef603@laptop2-ibm.local>
        <CAK7LNATL3Oyn=FLKm0TcB9SkJLuCOWV06a_t-FRtFiFp9Vda1g@mail.gmail.com>
        <20200214203536.GA133402@laptop.jcline.org>
        <CAK7LNAQ9+n8eRyUVrqTNDu915VcE+uHQoewH8WzJqpOpi8rT0Q@mail.gmail.com>
        <20200216185759.GA4091960@dev.jcline.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <20200218103752.6d4b9167@laptop2-ibm.local>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Jeremy Cline <jcline@redhat.com>
Cc: Masahiro Yamada <masahiroy@kernel.org>, Michal Kubecek <mkubecek@suse.cz>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>

Hi Masahiro,


On Sun, 16 Feb 2020 13:57:59 -0500
Jeremy Cline <jcline@redhat.com> wrote:

> On Sun, Feb 16, 2020 at 01:08:49PM +0900, Masahiro Yamada wrote:
> > On Sat, Feb 15, 2020 at 5:35 AM Jeremy Cline <jcline@redhat.com> wrote:  
> > >
> > > On Fri, Feb 14, 2020 at 12:31:05PM +0900, Masahiro Yamada wrote:  
> > > > Hi.
> > > >
> > > > On Tue, Feb 11, 2020 at 3:49 AM Philipp Rudo <prudo@linux.ibm.com> wrote:  

[...]

> > > > One idea to workaround this is
> > > > to use a fake script that accepts any flag,
> > > > and use it as $(CC) in Kconfig.
> > > >
> > > > RFC patch is attached.
> > > >
> > > > This is not a perfect solution, of course.

I like the approach as it gives both sides what they need without blowing up
Kconfig.

> > > The attached patch doesn't looks like it'd work for what we need,  
> > 
> > I thought turning all cc-options to y would work
> > for what you need.
> > 
> > With this, you can enable
> > CONFIG_MARCH_Z13=y and CONFIG_TUNE_Z14=y
> > instead of CONFIG_TUNE_DEFAULT.
> > 
> > If this approach does not work for you,
> > what is your requirement?
> >   
> 
> Oof, this was an awful typo. It *would* work for what we need. Sorry for
> the confusion :(.
> 
> > 
> >   
> > > although I wonder if it's easier to just check when cc-options is
> > > defined for an environment variable or something and always return y
> > > instead of calling out to $(CC) at all. Comes to the same thing, I
> > > suppose.  
> > 
> > 
> > The macro definition in scripts/Kconfig.include
> > takes precedence over any environment variable.
> > 
> > So, if you want to hack it from the environment,
> > you need to change the code somehow.
> > 
> > The scripts/dummy-tools/ approach does not change
> > anything for the use-case in upstream.
> > 
> > The result is the same, of course.
> >   
> 
> Indeed. Since I'm not maintaining it I don't have a particularly strong
> opinion about the approach. Whatever you like most works for me.

I agree with Jeremy. Just pick what you think is best.

Thanks a lot
Philipp
