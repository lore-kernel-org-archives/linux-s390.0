Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: Re: [PATCH/RFC] mm/debug_pagealloc: enable it by default
References: <1453463080-84320-1-git-send-email-borntraeger@de.ibm.com>
 <20160125064151.GA22557@js1304-P5Q-DELUXE>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Message-ID: <56A5DB21.2090300@de.ibm.com>
Date: Mon, 25 Jan 2016 09:21:53 +0100
MIME-Version: 1.0
In-Reply-To: <20160125064151.GA22557@js1304-P5Q-DELUXE>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Joonsoo Kim <iamjoonsoo.kim@lge.com>
Cc: linux-kernel@vger.kernel.org, peterz@infradead.org, heiko.carstens@de.ibm.com, akpm@linux-foundation.org, linux-s390 <linux-s390@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

On 01/25/2016 07:41 AM, Joonsoo Kim wrote:
> Hello,
> 
> On Fri, Jan 22, 2016 at 12:44:40PM +0100, Christian Borntraeger wrote:
>> since commit 031bc5743f158 ("mm/debug-pagealloc: make debug-pagealloc
>> boottime configurable") CONFIG_DEBUG_PAGEALLOC is by default a no-op.
>>
>> This resulted in several unnoticed bugs, e.g.
>> https://lkml.kernel.org/g/<569F5E29.3090107@de.ibm.com>
>> or
>> https://lkml.kernel.org/g/<56A20F30.4050705@de.ibm.com>
>>
>> as this behaviour change was not even documented in Kconfig.
>>
>> Let's go back to the original default and reverse the command
>> line parameter to allow disabling the feature.
> 
> Default disable is requested by Andrew and I agreed that.
> 
> https://lkml.org/lkml/2014/11/27/3

Well, Andrew's assumption was "I suspect the number of "old users" is one"
and this is wrong. I can at least claim, that most of the s390 test were 
conducted with CONFIG_DEBUG_PAGEALLOC enabled (at least regularly) - and 
about a year ago this was changed to "no longer useful". I have posted 2
real bugs that I triggered pretty quickly after I enabled things on the 
command line.
So my claim is, that the theoretical win of detecting more bugs by enabling 
this on the command line for distro kernels is far less than the real loss
of testers not triggering bugs in the last year.

Let me do some quick check with the kernels that I find in the rpm/deb repos
rawhide: # CONFIG_DEBUG_PAGEALLOC is not set
opensuse leap: # CONFIG_DEBUG_PAGEALLOC is not set
opensuse tumbleweed: # CONFIG_DEBUG_PAGEALLOC is not set
ubuntu 4.3 (kernel team repo) # CONFIG_DEBUG_PAGEALLOC is not set

So at least the communication was not done properly. :-(

> I think that default disable is good thing because we can use
> the kernel compiled with CONFIG_DEBUG_PAGEALLOC even for production.
> Unless boot param is provided, it's runtime cost is nearly zero.
> This could help to debug in some situations and make this debugging
> feature more useful. But, yes, old users can be surprised
> by this change. How about changing Kconfig to ask user for default mode?

A default mode would be ok for me as it makes things obvious. Will send
a patch.
