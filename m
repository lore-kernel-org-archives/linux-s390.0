Return-Path: <linux-kernel-owner+w=401wt.eu-S1755431AbYCLVjW@vger.kernel.org>
Message-ID: <47D84CEB.6050300@goop.org>
Date: Wed, 12 Mar 2008 14:36:43 -0700
From: Jeremy Fitzhardinge <jeremy@goop.org>
MIME-Version: 1.0
Subject: Re: [patch 6/6] Guest page hinting: s390 support.
References: <20080312132132.520833247@de.ibm.com>		<20080312132704.474209626@de.ibm.com>	<47D802A2.1030406@goop.org>		<1205339285.8851.13.camel@localhost>	<47D8085E.9030701@goop.org>	<1205341164.8851.44.camel@localhost>	<47D81771.5070400@goop.org> <47D8373C.40105@codemonkey.ws>	<47D840E3.5090902@goop.org> <47D8436F.9080901@codemonkey.ws>
In-Reply-To: <47D8436F.9080901@codemonkey.ws>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Anthony Liguori <anthony@codemonkey.ws>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, akpm@osdl.org, linux-s390@vger.kernel.org, frankeh@watson.ibm.com, nickpiggin@yahoo.com.au, linux-kernel@vger.kernel.org, virtualization@lists.osdl.org, schwidefsky@de.ibm.com, hugh@veritas.com
List-ID: <linux-s390.vger.kernel.org>

Anthony Liguori wrote:
>> Vp should never happen, since you'd never preserve a V page.  And 
>> surely it would be Pr -> Sr, since the hypervisor wouldn't push the 
>> page to backing store when you change the client state.
>>     
>
> You're right, I meant Vp/Pp but they are invalid states.  I think one of 
> the things that keeps tripping me up is that the host can change both 
> the host and guest page states.  My initial impression was that the host 
> handled the host state and the guest handled the guest state.
>   

Yes.  And it seems to me that you get unfortunate outcomes if you have a 
Pr->Vz->Vr transition.

>>> Do the host states even really need visibility to the guest at all?  
>>> It may be useful for the guest to be able to distinguish between Ur 
>>> and Uz but it doesn't seem necessary.
>>>       
>> Well, you implicitly see the hypervisor state.  If you touch a [UV]z 
>> page then you get a fault telling you that the page has been taken 
>> away from you (I think).  And it would definitely help with debugging 
>> (seems likely there's lots of scope for race conditions if you 
>> prematurely tell the hypervisor you don't need the page any more...).
>>     
>
> I was thinking that it may be useful to know a Ur verses a Uz when 
> allocating memory.  In this case, you'd rather allocate Ur pages verses 
> Uz to avoid the fault.  I don't read s390 arch code well, is the host 
> state explicit to the guest?
>   

Yes, reusing Ur pages might well be better, but who knows - they've 
probably got an instruction which makes Uz cheap...

Stuff like this suggets that both parts of the state are packed 
together, and are guest-visible:

+	return (state & ESSA_USTATE_MASK) == ESSA_USTATE_VOLATILE &&
+		(state & ESSA_CSTATE_MASK) == ESSA_CSTATE_ZERO;


      J
