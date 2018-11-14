From: Pierre Morel <pmorel@linux.ibm.com>
Date: Wed, 14 Nov 2018 18:30:16 +0000
Subject: Re: [RFC PATCH v1 00/10] vfio-ccw channel program rework
Message-Id: <8dd77a46-c04b-f8dc-4d13-acbe0cc793a4@linux.ibm.com>
In-Reply-To: <20181112165441.2ca1246f.cohuck@redhat.com>
References: <20181112165441.2ca1246f.cohuck@redhat.com>
To: linux-s390@vger.kernel.org, kvm@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On 09/11/2018 03:39, Eric Farman wrote:
> Hi Connie, Pierre,
> 
> This is a first round of rework to vfio-ccw that I've been cooking to
> make the channel program handler easier to understand.  My apologies
> for the number of patches; as there are some intersections within them
> I couldn't break them up without forcing them to be applied in a
> particular order.  I imagine that since there will probably need to be
> some discussion, an RFC tag makes sense and one giant series will be
> fine for now.  I can break them up for later versions if desired.
> 
> (Sidebar: I'm leaving next Thursday for an early start on the US
> Thanksgiving holiday.  So if you are busy and can't get to this,
> no problem!  Now where did I leave Pierre's rework patches...  :)
> 
> Patch summary:
> 
> 1-2:	Fixes for cleanup on error paths
> 3:	Code simplication

I am absolutely OK with these three first patches.


> 4-6:	Simplify the ccwchain processing
> 7-10:	Simplify the pfn_array processing

I still need some investigation on the last 7 ones.
On a first view, it looks generally good but I developed some ideas on 
the subject you address that you may want to study and may be implement 
as part of this memory optimization series:

- avoiding the multiples CCW chain alloc/free (already discussed in the 
dedicated patch)

- optimize the allocations of CCW chain metadata using kmem_caches
or
- dedicate a pre-allocated page to handle CCW chains in a single copy 
per subchain.
we would certainly never need more than a single page.



Regards,
Pierre

-- 
Pierre Morel
Linux/KVM/QEMU in B�blingen - Germany
