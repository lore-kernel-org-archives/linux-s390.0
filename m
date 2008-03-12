Return-Path: <linux-kernel-owner+w=401wt.eu-S1754831AbYCLUE0@vger.kernel.org>
Message-ID: <47D8373C.40105@codemonkey.ws>
Date: Wed, 12 Mar 2008 15:04:12 -0500
From: Anthony Liguori <anthony@codemonkey.ws>
MIME-Version: 1.0
Subject: Re: [patch 6/6] Guest page hinting: s390 support.
References: <20080312132132.520833247@de.ibm.com>	 <20080312132704.474209626@de.ibm.com>  <47D802A2.1030406@goop.org>	 <1205339285.8851.13.camel@localhost>  <47D8085E.9030701@goop.org> <1205341164.8851.44.camel@localhost> <47D81771.5070400@goop.org>
In-Reply-To: <47D81771.5070400@goop.org>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: schwidefsky@de.ibm.com, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, virtualization@lists.osdl.org, akpm@osdl.org, nickpiggin@yahoo.com.au, frankeh@watson.ibm.com, hugh@veritas.com
List-ID: <linux-s390.vger.kernel.org>

Jeremy Fitzhardinge wrote:
>> With stable_if_clean you are refering to stable_if_present?
> 
> No.  I misunderstood and thought that stable_if_present sets the Px 
> state.  I'd overlooked the writable flag on page_set_volatile().
> 
>>  If yes the
>> answer is that this operation is used to get a page from Vx/Px back to
>> Sx but only if the page has not been discarded.
> 
> So you mean it will change Vr/Pr to Sr but everything else will fail?  

Well presumably Vp/Pr => Sp?  Is is true that from the guest's 
perspective, all of the 'p' states are identical to the 'r' states?

Do the host states even really need visibility to the guest at all?  It 
may be useful for the guest to be able to distinguish between Ur and Uz 
but it doesn't seem necessary.

BTW Jeremy, the .dot was very useful!

Regards,

Anthony Liguori
