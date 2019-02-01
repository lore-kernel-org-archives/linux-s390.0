Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
Subject: Re: [PATCH] zcrypt: handle AP Info notification from CHSC SEI command
References: <1548870526-30595-1-git-send-email-akrowiak@linux.ibm.com>
 <alpine.LFD.2.21.1901301912380.2372@schleppi>
 <88b72363-9dca-4653-c326-9c37b6349a32@linux.ibm.com>
 <20190201090159.GC3770@osiris> <20190201130548.GF3770@osiris>
From: Tony Krowiak <akrowiak@linux.ibm.com>
Date: Fri, 1 Feb 2019 10:40:11 -0500
MIME-Version: 1.0
In-Reply-To: <20190201130548.GF3770@osiris>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <c1564ff4-a07a-90d0-76cc-51ccc5b074cc@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Heiko Carstens <heiko.carstens@de.ibm.com>, Sebastian Ott <sebott@linux.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, oberpar@linux.ibm.com, freude@linux.ibm.com, pmorel@linux.ibm.com, pasic@linux.ibm.com, cohuck@redhat.com
List-ID: <linux-s390.vger.kernel.org>

On 2/1/19 8:05 AM, Heiko Carstens wrote:
> On Fri, Feb 01, 2019 at 10:01:59AM +0100, Heiko Carstens wrote:
>> On Thu, Jan 31, 2019 at 06:28:39PM -0500, Tony Krowiak wrote:
>>> On 1/30/19 1:32 PM, Sebastian Ott wrote:
>>>> On Wed, 30 Jan 2019, Tony Krowiak wrote:
>>>>> +#if IS_ENABLED(CONFIG_ZCRYPT)
>>>>> +void ap_bus_cfg_chg(void);
> ...
>> Also the above should be "#ifdef CONFIG_ZCRYPT".

Okay

> 
> Please ignore that part of my comment.
> I always forget the CONFIG_ZCRYPT_MODULE option.
> 
