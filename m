From: Wei Yang <richard.weiyang@gmail.com>
Subject: Re: [PATCH RFCv2 1/4] mm/memory_hotplug: Introduce memory block types
Date: Mon, 3 Dec 2018 20:58:36 +0000
Message-ID: <20181203205836.7xpab6ljc3kngrqm@master>
References: <20181130175922.10425-1-david@redhat.com>
 <20181130175922.10425-2-david@redhat.com>
 <20181201012507.lxfscl6ho3gc6gnn@master>
 <af797dbb-0537-19ec-ef31-d72a3f979791@redhat.com>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <af797dbb-0537-19ec-ef31-d72a3f979791@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-acpi/>
List-Post: <mailto:linux-acpi@vger.kernel.org>
To: David Hildenbrand <david@redhat.com>
Cc: Wei Yang <richard.weiyang@gmail.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, linux-acpi@vger.kernel.org, devel@linuxdriverproject.org, xen-devel@lists.xenproject.org, x86@kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>, Pavel Tatashin <pasha.tatashin@oracle.com>, Stephen Rothwell <sfr@canb.auug.org.au>, Andrew Banman <andrew.banman@hpe.com>, "mike.travis@hpe.com" <mike.travis@hpe.com>, Oscar Salvador <osalvador@suse.com>, Dave Hansen <dave.hansen@linux.intel.com>, Michal Hocko <mhocko@kernel.org>Michal
List-ID: <linux-s390.vger.kernel.org>

[...]
>>>
>>> +	if (type == MEMORY_BLOCK_NONE)
>>> +		return -EINVAL;
>> 
>> No one will pass in this value. Can we omit this check for now?
>
>I could move it to patch nr 2 I guess, but as I introduce
>MEMORY_BLOCK_NONE here it made sense to keep it in here.
>

Yes, this make sense to me now.

>(and I think at least for now it makes sense to not squash patch 1 and
>2, to easier discuss the new user interface/concept introduced in this
>patch).
>
>Thanks!
>
>-- 
>
>Thanks,
>
>David / dhildenb

-- 
Wei Yang
Help you, Help me
