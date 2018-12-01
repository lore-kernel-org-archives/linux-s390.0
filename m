From: Wei Yang <richard.weiyang@gmail.com>
Subject: Re: [PATCH RFCv2 0/4] mm/memory_hotplug: Introduce memory block types
Date: Sat, 1 Dec 2018 00:48:36 +0000
Message-ID: <20181201004836.jr6r3vyenpph3agj@master>
References: <20181130175922.10425-1-david@redhat.com>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <driverdev-devel-bounces@linuxdriverproject.org>
Content-Disposition: inline
In-Reply-To: <20181130175922.10425-1-david@redhat.com>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
List-Archive: <https://lore.kernel.org/linux-acpi/>
List-Post: <mailto:linux-acpi@vger.kernel.org>
To: David Hildenbrand <david@redhat.com>
Cc: Oscar Salvador <osalvador@suse.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Michal Hocko <mhocko@suse.com>, linux-ia64@vger.kernel.org, linux-sh@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Balbir Singh <bsingharora@gmail.com>, Dave Hansen <dave.hansen@linux.intel.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Michal Hocko <mhocko@kernel.org>, linux-mm@kvack.org, Pavel Tatashin <pavel.tatashin@microsoft.com>, Rich Felker <dalias@libc.org>, Arun KS <arunks@codeaurora.org>, "H. Peter Anvin" <hpa@zytor.com>, Stephen Rothwell <sfr@canb.auug.org.au>, Rashmica Gupta <rashmica.g@gmail.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Paul Mackerras <paulus@samba.org>, Pavel Tatashin <pasha.tatashin@soleen.com>, linux-s390@vger.kernel.org, Michael Neuling <mikey@neuling.org>, Stefano Stabellini <sstabellini@k>
List-ID: <linux-s390.vger.kernel.org>

On Fri, Nov 30, 2018 at 06:59:18PM +0100, David Hildenbrand wrote:
>This is the second approach, introducing more meaningful memory block
>types and not changing online behavior in the kernel. It is based on
>latest linux-next.
>
>As we found out during dicussion, user space should always handle onlining
>of memory, in any case. However in order to make smart decisions in user
>space about if and how to online memory, we have to export more information
>about memory blocks. This way, we can formulate rules in user space.
>
>One such information is the type of memory block we are talking about.
>This helps to answer some questions like:
>- Does this memory block belong to a DIMM?
>- Can this DIMM theoretically ever be unplugged again?
>- Was this memory added by a balloon driver that will rely on balloon
>  inflation to remove chunks of that memory again? Which zone is advised?
>- Is this special standby memory on s390x that is usually not automatically
>  onlined?
>
>And in short it helps to answer to some extend (excluding zone imbalances)
>- Should I online this memory block?
>- To which zone should I online this memory block?
>... of course special use cases will result in different anwers. But that's
>why user space has control of onlining memory.
>
>More details can be found in Patch 1 and Patch 3.
>Tested on x86 with hotplugged DIMMs. Cross-compiled for PPC and s390x.
>
>
>Example:
>$ udevadm info -q all -a /sys/devices/system/memory/memory0
>	KERNEL=="memory0"
>	SUBSYSTEM=="memory"
>	DRIVER==""
>	ATTR{online}=="1"
>	ATTR{phys_device}=="0"
>	ATTR{phys_index}=="00000000"
>	ATTR{removable}=="0"
>	ATTR{state}=="online"
>	ATTR{type}=="boot"
>	ATTR{valid_zones}=="none"
>$ udevadm info -q all -a /sys/devices/system/memory/memory90
>	KERNEL=="memory90"
>	SUBSYSTEM=="memory"
>	DRIVER==""
>	ATTR{online}=="1"
>	ATTR{phys_device}=="0"
>	ATTR{phys_index}=="0000005a"
>	ATTR{removable}=="1"
>	ATTR{state}=="online"
>	ATTR{type}=="dimm"
>	ATTR{valid_zones}=="Normal"
>
>
>RFC -> RFCv2:
>- Now also taking care of PPC (somehow missed it :/ )
>- Split the series up to some degree (some ideas on how to split up patch 3
>  would be very welcome)
>- Introduce more memory block types. Turns out abstracting too much was
>  rather confusing and not helpful. Properly document them.
>
>Notes:
>- I wanted to convert the enum of types into a named enum but this
>  provoked all kinds of different errors. For now, I am doing it just like
>  the other types (e.g. online_type) we are using in that context.
>- The "removable" property should never have been named like that. It
>  should have been "offlinable". Can we still rename that? E.g. boot memory
>  is sometimes marked as removable ...
>

This make sense to me. Remove usually describe physical hotplug phase,
if I am correct. 

-- 
Wei Yang
Help you, Help me
