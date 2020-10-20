Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: Re: [PATCH] drivers/virt: vmgenid: add vm generation id driver
References: <788878CE-2578-4991-A5A6-669DCABAC2F2@amazon.com>
 <CAG48ez0EanBvDyfthe+hAP0OC8iGLNSq2e5wJVz-=ENNGF97_w@mail.gmail.com>
 <20201017033606.GA14014@1wt.eu>
 <CAG48ez0x2S9XuCrANAQbXNi8Jjwm822-fnQSmr-Zr07JgrEs1g@mail.gmail.com>
 <6CC3DB03-27BA-4F5E-8ADA-BE605D83A85C@amazon.com>
 <CAG48ez1ZtvjOs2CEq8-EMosPCd_o7WQ3Mz_+1mDe7OrH2arxFA@mail.gmail.com>
 <20201017053712.GA14105@1wt.eu>
 <CAG48ez1h0ynXfGap_KiHiPVTfcB8NBQJ-2dnj08ZNfuhrW0jWA@mail.gmail.com>
 <20201017064442.GA14117@1wt.eu>
 <CAG48ez3pXLC+eqAXDCniM0a+5yP2XJODDkZqiUTZUOttCE_LbA@mail.gmail.com>
 <CAHmME9qHGSF8w3DoyCP+ud_N0MAJ5_8zsUWx=rxQB1mFnGcu9w@mail.gmail.com>
 <aacdff7a-2af1-4f46-6ab2-2a9d5b865d35@amazon.de>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Message-ID: <2e505365-db4a-6054-8bc8-f9a81978c6d4@de.ibm.com>
Date: Tue, 20 Oct 2020 11:35:35 +0200
In-Reply-To: <aacdff7a-2af1-4f46-6ab2-2a9d5b865d35@amazon.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
List-ID: <linux-s390.vger.kernel.org>
To: Alexander Graf <graf@amazon.de>, "Jason A. Donenfeld" <Jason@zx2c4.com>, Jann Horn <jannh@google.com>
Cc: Willy Tarreau <w@1wt.eu>, Colm MacCarthaigh <colmmacc@amazon.com>, "Catangiu, Adrian Costin" <acatan@amazon.com>, Andy Lutomirski <luto@kernel.org>, "Theodore Y. Ts'o" <tytso@mit.edu>, Eric Biggers <ebiggers@kernel.org>, "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, kernel list <linux-kernel@vger.kernel.org>, "open list:VIRTIO GPU DRIVER" <virtualization@lists.linux-foundation.org>, "Woodhouse, David" <dwmw@amazon.co.uk>, bonzini@gnu.org, "Singh, Balbir" <sblbir@amazon.com>, "Weiss, Radu" <raduweis@amazon.com>, oridgar@gmail.com, ghammer@redhat.com, Jonathan Corbet <corbet@lwn.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Michael S. Tsirkin" <mst@redhat.com>, Qemu Developers <qemu-devel@nongnu.org>, KVM list <kvm@vger.kernel.org>, Michal Hocko <mhocko@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@ucw.cz>, Linux API <linux-api@vger.kernel.org>, mpe@ellerman.id.au, linux-s390 <linux-s390@vger.kernel.org>



On 17.10.20 20:09, Alexander Graf wrote:
> Hi Jason,
> 
> On 17.10.20 15:24, Jason A. Donenfeld wrote:
>>
>> After discussing this offline with Jann a bit, I have a few general
>> comments on the design of this.
>>
>> First, the UUID communicated by the hypervisor should be consumed by
>> the kernel -- added as another input to the rng -- and then userspace
> 
> We definitely want a kernel internal notifier as well, yes :).
> 
>> should be notified that it should reseed any userspace RNGs that it
>> may have, without actually communicating that UUID to userspace. IOW,
> 
> I also tend to agree that it makes sense to disconnect the actual UUID we receive from the notification to user space. This would allow us to create a generic mechanism for VM save/restore cycles across different hypervisors. Let me add PPC and s390x people to the CC list to see whether they have anything remotely similar to the VmGenID mechanism. For x86 and aarch64, the ACPI and memory based VmGenID implemented here is the most obvious option to implement IMHO. It's also already implemented in all major hypervisors.

Hmm, what we do have configurations (e.g. stfle bits) and we do have a notification mechanism via sclp that notifies guests when things change.
As of today neither KVM nor Linux implement the sclp change notification mechanism, but I do see value in such a thing.

> 
>> I agree with Jann there. Then, it's the functioning of this
>> notification mechanism to userspace that is interesting to me.
> 
> Absolutely! Please have a look at the previous discussion here:
> 
> 
> https://lore.kernel.org/linux-pm/B7793B7A-3660-4769-9B9A-FFCF250728BB@amazon.com/
> 
> The user space interface is absolutely what this is about.

Yes. Passing a notification to userspace is essential. Where I do not see a solution yet is the race between notification and
already running with the old knowledge.
> 
>> There are a few design goals of notifying userspace: it should be
>> fast, because people who are using userspace RNGs are usually doing so
>> in the first place to completely avoid syscall overhead for whatever
>> high performance application they have - e.g. I recall conversations
>> with Colm about his TLS implementation needing to make random IVs
>> _really_ fast. It should also happen as early as possible, with no
>> race or as minimal as possible race window, so that userspace doesn't
>> begin using old randomness and then switch over after the damage is
>> already done.
> 
> There are multiple facets and different types of consumers here. For a user space RNG, I agree that fast and as race free as possible is key. That's what the mmap interface is there for.
> 
> There are applications way beyond that though. What do you do with applications that already consumed randomness? For example a cached pool of SSL keys. Or a higher level language primitive that consumes randomness and caches its seed somewhere in an internal data structure. Or even worse: your system's host ssh key.
> 
> For those types of events, an mmap (or vDSO) interface does not work. We need to actively allow user space applications to readjust to the new environment - either internally (the language primitive case) or through a system event, maybe even as systemd trigger (the ssh host key case).
> 
> To give everyone enough time before we consider a system as "updated to the new environment", we have the callback logic with the "Orchestrator" that can check whether all listeners to system wide updates confirms they adjusted themselves.
> 
> That's what the rest of the logic is there for: A read+poll interface and all of the orchestration logic. It's not for the user space RNG case, it's for all of its downstream users.
> 
>> I'm also not wedded to using Microsoft's proprietary hypervisor design
>> for this. If we come up with a better interface, I don't think it's
>> asking too much to implement that and reasonably expect for Microsoft
>> to catch up. Maybe someone here will find that controversial, but
>> whatever -- discussing ideal designs does not seem out of place or
>> inappropriate for how we usually approach things in the kernel, and a
>> closed source hypervisor coming along shouldn't disrupt that.
> 
> The main bonus point on this interface is that Hyper-V, VMware and QEMU implement it already. It would be a very natural for into the ecosystem. I agree though that we shouldn't have our user space interface necessarily dictated by it: Other hypervisors may implement different ways such as a simple edge IRQ that gets triggered whenever the VM gets resumed.
> 
>> So, anyway, here are a few options with some pros and cons for the
>> kernel notifying userspace that its RNG should reseed.
> 
> I can only stress again that we should not be laser focused on the RNG case. In a lot of cases, data has already been generated by the RNG before the snapshot and needs to be reinitialized after the snapshot. In other cases such as system UUIDs, it's completely orthogonal to the RNG.
> 
>>
>> 1. SIGRND - a new signal. Lol.
> 
> Doable, but a lot of plumbing in user space. It's also not necessarily a good for for event notification in most user space applications.
> 
>>
>> 2. Userspace opens a file descriptor that it can epoll on. Pros are
>> that many notification mechanisms already use this. Cons is that this
>> requires syscall and might be more racy than we want. Another con is
>> that this a new thing for userspace programs to do.
> 
> That's part of what this patch does, right? This patch implements read+poll as well as mmap() for high speed reads.
> 
>> 3. We stick an atomic counter in the vDSO, Jann's suggestion. Pros are
>> that this is extremely fast, and also simple to use and implement.
>> There are enough sequence points in typical crypto programs that
>> checking to see whether this counter has changed before doing whatever
>> operation seems easy enough. Cons are that typically we've been
>> conservative about adding things to the vDSO, and this is also a new
>> thing for userspace programs to do.
> 
> The big con is that its use is going to be super limited to applications that can be adapted to check their "vm generation" through a vDSO call / read every time they consume data that may potentially need to be regenerated.
> 
> This probably works for the pure RNG case. It falls apart for more sophisticated things such as "redo my ssh host keys and restart the service" or "regenerate my samba machine uuid".
> 
>> 4. We already have a mechanism for this kind of thing, because the
>> same issue comes up when fork()ing. The solution was MADV_WIPEONFORK,
>> where userspace marks a page to be zeroed when forking, for the
>> purposes of the RNG being notified when its world gets split in two.
>> This is basically the same thing as we're discussing here with guest
>> snapshots, except it's on the system level rather than the process
>> level, and a system has many processes. But the problem space is still
>> almost the same, and we could simply reuse that same mechanism. There
>> are a few implementation strategies for that:
> 
> Yup, that's where we started from :). And then we ran into resistance by the mm people (on CC here). And then we looked at the problem more in depth and checked what it would take to for example implement this for user space RNGs in Java. It's ... more complicated than one may think at first.
> 
>> 4a. We mess with the PTEs of all processes' pages that are
>> MADV_WIPEONFORK, like fork does now, when the hypervisor notifies us
>> to do so. Then we wind up reusing the already existing logic for
>> userspace RNGs. Cons might be that this usually requires semaphores,
>> and we're in irq context, so we'd have to hoist to a workqueue, which
>> means either more wake up latency, or a larger race window.
>>
>> 4b. We just memzero all processes' pages that are MADV_WIPEONFORK,
>> when the hypervisor notifies us to do so. Then we wind up reusing the
>> already existing logic for userspace RNGs.
>>
>> 4c. The guest kernel maintains an array of physical addresses that are
>> MADV_WIPEONFORK. The hypervisor knows about this array and its
>> location through whatever protocol, and before resuming a
>> moved/snapshotted/duplicated VM, it takes the responsibility for
>> memzeroing this memory. The huge pro here would be that this
>> eliminates all races, and reduces complexity quite a bit, because the
>> hypervisor can perfectly synchronize its bringup (and SMP bringup)
>> with this, and it can even optimize things like on-disk memory
>> snapshots to simply not write out those pages to disk.
>>
>> A 4c-like approach seems like it'd be a lot of bang for the buck -- we
>> reuse the existing mechanism (MADV_WIPEONFORK), so there's no new
>> userspace API to deal with, and it'd be race free, and eliminate a lot
>> of kernel complexity.
>>
>> But 4b and 3 don't seem too bad either.
>>
>> Any thoughts on 4c? Is that utterly insane, or does that actually get
>> us somewhere close to what we want?
> 
> All of the options for "4" are possible and have an RFC out. Please check out the discussion linked above :).
> 
> The problem with anything that relies on close loop reads (options 3+4) is not going to work well with the more sophisticated use case of derived data.
> 
> IMHO it will boil down to "both". We will need a high-speed interface that with close-to-0 overhead tells you either the generation ID or clears pages (options 3+4) as well as something that is bigger for applications that can either intrinsically (sshd) or by system design (Java) not adopt the mechanisms above easily.
> 
> That said, we need to start somewhere. I don't mind which angle we start from. But this is a real world problem and one that will only become more prevalent over time as VMs are used for more than only your traditional enterprise hardware consolidation.
> 
> 
> Alex
> 
> 
> 
> Amazon Development Center Germany GmbH
> Krausenstr. 38
> 10117 Berlin
> Geschaeftsfuehrung: Christian Schlaeger, Jonathan Weiss
> Eingetragen am Amtsgericht Charlottenburg unter HRB 149173 B
> Sitz: Berlin
> Ust-ID: DE 289 237 879
> 
> 
