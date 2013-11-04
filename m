Return-Path: <linux-kernel-owner@vger.kernel.org>
Message-ID: <5277B629.9060108@free-electrons.com>
Date: Mon, 04 Nov 2013 15:58:49 +0100
From: Michael Opdenacker <michael.opdenacker@free-electrons.com>
MIME-Version: 1.0
Subject: Re: [PATCH] s390: remove unused Kconfig parameters
References: <1383558219-5223-1-git-send-email-michael.opdenacker@free-electrons.com> <20131104110849.GA4117@osiris>
In-Reply-To: <20131104110849.GA4117@osiris>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: schwidefsky@de.ibm.com, linux390@de.ibm.com, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Hi Heiko,

Thank you for reviewing my patch!

On 11/04/2013 12:08 PM, Heiko Carstens wrote:
> On Mon, Nov 04, 2013 at 10:43:39AM +0100, Michael Opdenacker wrote:
>> This removes the HAVE_MARCH_Z900_FEATURES and
>> HAVE_MARCH_Z990_FEATURES Kconfig parameters,
>> which were no longer used anywhere in the source code
>> and Makefiles.
>>
>> Actually, HAVE_MARCH_Z990_FEATURES is no longer used
>> after removing HAVE_MARCH_Z900_FEATURES.
>>
>> Signed-off-by: Michael Opdenacker <michael.opdenacker@free-electrons.com>
> Thanks for the patch. However each architecture generation is supposed to
> have its own "HAVE_MARCH_*" config.
> Even if its not used right now, it might create problems in the future
> if they are only partially present.
> So I'm not going to apply your patch.
I understand. No problem. That's your choice as a maintainer. I'm just
trying to help :)

Thanks again,

Michael.

-- 
Michael Opdenacker, CEO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
+33 484 258 098
