Return-Path: <linux-kernel-owner@vger.kernel.org>
Message-ID: <542A3F7C.5000308@free-electrons.com>
Date: Tue, 30 Sep 2014 07:28:28 +0200
From: Michael Opdenacker <michael.opdenacker@free-electrons.com>
MIME-Version: 1.0
Subject: Re: [PATCH] s390: remove unused Kconfig params
References: <1411799130-17875-1-git-send-email-michael.opdenacker@free-electrons.com> <20140927075701.GA6926@osiris>
In-Reply-To: <20140927075701.GA6926@osiris>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: schwidefsky@de.ibm.com, linux390@de.ibm.com, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Hi Heiko,

On 09/27/2014 09:57 AM, Heiko Carstens wrote:
> On Sat, Sep 27, 2014 at 08:25:30AM +0200, Michael Opdenacker wrote:
>> Remove the below Kconfig parameters, which are no longer
>> used anywhere in the source code and Makefiles:
>>
>> HAVE_MARCH_Z900_FEATURES
>> HAVE_MARCH_Z990_FEATURES
>>
>> Signed-off-by: Michael Opdenacker <michael.opdenacker@free-electrons.com>
> What I wrote you a year ago is still true:
>
> https://lkml.org/lkml/2013/11/4/69

Thanks for your reply. I forgot about my earlier submission, as I only
keep track of patches that haven't been accepted yet. I will keep track
of "hopeless" rejected patches too...

There are multiple opinions about whether adding stuff not needed yet,
or adding stuff only once they are needed. Anyway, as a maintainer, the
decision is yours!

Cheers,

Michael.

-- 
Michael Opdenacker, CEO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
+33 484 258 098
