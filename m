Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: Re: [PATCH AUTOSEL 4.19 204/205] s390/qeth: limit csum offload
 erratum to L3 devices
References: <20191108113752.12502-1-sashal@kernel.org>
 <20191108113752.12502-204-sashal@kernel.org>
 <2e4553d6-de1f-bb61-33e4-10a5c23f0aa7@linux.ibm.com>
 <20191108120025.GM4787@sasha-vm>
From: Julian Wiedmann <jwi@linux.ibm.com>
Date: Fri, 8 Nov 2019 13:16:26 +0100
MIME-Version: 1.0
In-Reply-To: <20191108120025.GM4787@sasha-vm>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <4d8f1938-af6e-7e0e-4085-2f7c53390b2d@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Sasha Levin <sashal@kernel.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org, "David S . Miller" <davem@davemloft.net>, linux-s390@vger.kernel.org

On 08.11.19 13:00, Sasha Levin wrote:
> On Fri, Nov 08, 2019 at 12:50:24PM +0100, Julian Wiedmann wrote:
>> On 08.11.19 12:37, Sasha Levin wrote:
>>> From: Julian Wiedmann <jwi@linux.ibm.com>
>>>
>>> [ Upstream commit f231dc9dbd789b0f98a15941e3cebedb4ad72ad5 ]
>>>
>>> Combined L3+L4 csum offload is only required for some L3 HW. So for
>>> L2 devices, don't offload the IP header csum calculation.
>>>
>>
>> NACK, this has no relevance for stable.
> 
> Sure, I'll drop it.
> 
> Do you have an idea why the centos and ubuntu folks might have
> backported this commit into their kernels?
> 

No clue, I trust they have their own reasons.
