From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Subject: Re: [RFC PATCH 0/3] Report guest steal time in host
Date: Wed, 22 Apr 2015 17:09:02 +0530
Message-ID: <20150422113902.GA14738@naverao1-tp.in.ibm.com>
References: <cover.1429696326.git.naveen.n.rao@linux.vnet.ibm.com>
 <55378065.3040002@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <kvm-ppc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <55378065.3040002@de.ibm.com>
Sender: kvm-ppc-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: kvm@vger.kernel.org, kvm-ppc@vger.kernel.org, paulus@samba.org, mpe@ellerman.id.au, agraf@suse.de, mingo@redhat.com, ego@linux.vnet.ibm.com, linux-s390 <linux-s390@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

On 2015/04/22 01:05PM, Christian Borntraeger wrote:
> Am 22.04.2015 um 12:24 schrieb Naveen N. Rao:
> > Steal time accounts the time duration during which a guest vcpu was ready to
> > run, but was not scheduled to run by the hypervisor. This is particularly
> > relevant in cloud environment where customers would want to use this as an
> > indicator that their guests are being throttled. However, as it stands today,
> > guest steal time information is not visible from the hypervisor.
> > 
> > For cloud service providers, this is problematic since they would want to
> > overcommit cpu resources to achieve optimum resource utilization while at the
> > same time ensuring guests are not throttled. It is useful for service providers
> > to have access to the guest steal time data so that they can base their
> > overcommit/guest packing decisions on this. Higher guest steal time can be used
> > as a trigger to change how the guests are scheduled, or even migrate guests out
> > of a system.
> > 
> > This patchset attempts to make the guest steal times available in the host.
> > This is achieved by introducing a new field in per-task statistics
> > (/proc/<pid>/stat and /proc/<pid>/task/<pid>/stat) to accumulate per-vcpu steal
> > time. Programs (such as pidstat) can then be enhanced to report this
> > information on a per-thread basis [If there is a better place/way to expose
> > this, please let me know]. As an example, with pidstat on ppc64:
> > 
> > Guest steal time information using mpstat:
> > -----------------------------------------
> > 
> > [root@rhel7-img ~]# mpstat -P ALL 1
> > Linux 3.19.0nnr (rhel7-img) 	04/15/2015 	_ppc64_	(4 CPU)
> > 
> > 03:13:23 PM  CPU    %usr   %nice    %sys %iowait    %irq   %soft  %steal  %guest  %gnice   %idle
> > 03:13:24 PM  all   12.25    0.00    1.25    0.00    1.00    2.25   13.75    0.00    0.00   69.50
> > 03:13:24 PM    0   46.53    0.00    0.00    0.00    0.00    4.95   45.54    0.00    0.00    2.97
> > 03:13:24 PM    1    0.00    0.00    0.00    0.00    0.00    4.04    3.03    0.00    0.00   92.93
> > 03:13:24 PM    2    0.00    0.00    0.00    0.00    3.96    0.99    2.97    0.00    0.00   92.08
> > 03:13:24 PM    3    3.00    0.00    4.00    0.00    0.00    0.00    4.00    0.00    0.00   89.00
> > 
> > 03:13:24 PM  CPU    %usr   %nice    %sys %iowait    %irq   %soft  %steal  %guest  %gnice   %idle
> > 03:13:25 PM  all   12.59    0.00    0.00    0.00    0.00    0.25   12.35    0.00    0.00   74.81
> > 03:13:25 PM    0   50.00    0.00    0.00    0.00    0.00    0.98   49.02    0.00    0.00    0.00
> > 03:13:25 PM    1    0.98    0.00    0.00    0.00    0.00    0.00    0.00    0.00    0.00   99.02
> > 03:13:25 PM    2    0.00    0.00    0.00    0.00    0.00    0.00    0.00    0.00    0.00  100.00
> > 03:13:25 PM    3    0.00    0.00    0.00    0.00    0.00    0.00    0.00    0.00    0.00  100.00
> > 
> > 03:13:25 PM  CPU    %usr   %nice    %sys %iowait    %irq   %soft  %steal  %guest  %gnice   %idle
> > 03:13:26 PM  all   12.99    0.00    0.00    0.00    0.25    0.00   12.75    0.00    0.00   74.02
> > 03:13:26 PM    0   51.96    0.00    0.00    0.00    0.00    0.00   48.04    0.00    0.00    0.00
> > 03:13:26 PM    1    0.00    0.00    0.00    0.00    0.00    0.00    0.00    0.00    0.00  100.00
> > 03:13:26 PM    2    0.00    0.00    0.00    0.00    0.98    0.00    2.94    0.00    0.00   96.08
> > 03:13:26 PM    3    0.00    0.00    0.00    0.00    0.00    0.00    0.00    0.00    0.00  100.00
> > 
> > 03:13:26 PM  CPU    %usr   %nice    %sys %iowait    %irq   %soft  %steal  %guest  %gnice   %idle
> > 03:13:27 PM  all   12.53    0.00    1.00    0.25    0.00    0.25   12.03    0.00    0.00   73.93
> > 03:13:27 PM    0   51.02    0.00    0.00    0.00    0.00    0.00   48.98    0.00    0.00    0.00
> > 03:13:27 PM    1    0.00    0.00    4.04    0.00    0.00    0.00    0.00    0.00    0.00   95.96
> > 03:13:27 PM    2    0.00    0.00    0.00    0.00    0.00    0.00    0.00    0.00    0.00  100.00
> > 03:13:27 PM    3    0.00    0.00    0.00    0.00    0.00    0.00    0.00    0.00    0.00  100.00
> > 
> > Average:     CPU    %usr   %nice    %sys %iowait    %irq   %soft  %steal  %guest  %gnice   %idle
> > Average:     all   12.91    0.00    0.54    0.01    0.04    0.12   12.39    0.00    0.00   74.00
> > Average:       0   51.36    0.00    0.03    0.00    0.03    0.26   48.27    0.00    0.00    0.05
> > Average:       1    0.02    0.00    1.54    0.02    0.02    0.15    0.36    0.00    0.00   97.89
> > Average:       2    0.00    0.00    0.52    0.00    0.09    0.02    0.36    0.00    0.00   99.02
> > Average:       3    0.05    0.00    0.07    0.00    0.02    0.09    0.34    0.00    0.00   99.43
> > 
> > Steal time information in host using (locally modified) pidstat:
> > ---------------------------------------------------------------
> > 
> > [naveen@xxxxxxxxxx sysstat]$ ./pidstat -C qemu -tIu 1
> > Linux 3.19.0nnr (xxxxxxxxxx.in.ibm.com) 	04/15/2015 	_ppc64_	(64 CPU)
> > 
> > 04:43:20 AM   UID      TGID       TID    %usr %system  %guest    %CPU  %steal   CPU  Command
> > 04:43:22 AM  1008      3001         -    0.00    0.00   54.21    3.39   45.79    12  qemu-system-ppc
> > 04:43:22 AM  1008         -      3005    0.00    0.00   54.21    3.39    0.00    12  |__qemu-system-ppc
> > 
> > 04:43:22 AM   UID      TGID       TID    %usr %system  %guest    %CPU  %steal   CPU  Command
> > 04:43:23 AM  1008      3001         -    0.00    0.00   52.00    3.25   46.00    12  qemu-system-ppc
> > 04:43:23 AM  1008         -      3003    0.00    0.00    2.00    0.12   46.00    12  |__qemu-system-ppc
> > 04:43:23 AM  1008         -      3005    0.00    0.00   45.00    2.81    0.00    12  |__qemu-system-ppc
> > 04:43:23 AM  1008         -      3006    0.00    0.00    6.00    0.38    0.00    12  |__qemu-system-ppc
> > 
> > 04:43:23 AM   UID      TGID       TID    %usr %system  %guest    %CPU  %steal   CPU  Command
> > 04:43:24 AM  1008      3001         -    0.00    2.00   50.00    3.25   67.00    12  qemu-system-ppc
> > 04:43:24 AM  1008         -      3001    0.00    1.00    0.00    0.06    0.00    12  |__qemu-system-ppc
> > 04:43:24 AM  1008         -      3003    0.00    0.00    8.00    0.50   49.00    12  |__qemu-system-ppc
> > 04:43:24 AM  1008         -      3004    0.00    0.00    2.00    0.12    5.00    12  |__qemu-system-ppc
> > 04:43:24 AM  1008         -      3005    0.00    0.00   38.00    2.38    3.00    12  |__qemu-system-ppc
> > 04:43:24 AM  1008         -      3006    0.00    1.00    0.00    0.06    8.00    12  |__qemu-system-ppc
> > 
> > 04:43:24 AM   UID      TGID       TID    %usr %system  %guest    %CPU  %steal   CPU  Command
> > 04:43:25 AM  1008      3001         -    0.00    0.00   51.00    3.19   47.00    12  qemu-system-ppc
> > 04:43:25 AM  1008         -      3003    0.00    0.00   27.00    1.69   47.00    12  |__qemu-system-ppc
> > 04:43:25 AM  1008         -      3004    0.00    1.00    0.00    0.06    0.00    12  |__qemu-system-ppc
> > 04:43:25 AM  1008         -      3005    0.00    1.00   23.00    1.50    0.00    12  |__qemu-system-ppc
> > 04:43:25 AM  1008         -      3006    0.00    0.00    2.00    0.12    0.00    12  |__qemu-system-ppc
> > 
> > 04:43:25 AM   UID      TGID       TID    %usr %system  %guest    %CPU  %steal   CPU  Command
> > 04:43:26 AM  1008      3001         -    0.00    0.00   51.00    3.18   53.00    12  qemu-system-ppc
> > 04:43:26 AM  1008         -      3003    0.00    0.00    9.00    0.56   50.00    12  |__qemu-system-ppc
> > 04:43:26 AM  1008         -      3005    0.00    0.00   16.00    1.00    3.00    12  |__qemu-system-ppc
> > 04:43:26 AM  1008         -      3006    0.00    0.00   26.00    1.62    0.00    12  |__qemu-system-ppc
> > 
> > Average:      UID      TGID       TID    %usr %system  %guest    %CPU  %steal   CPU  Command
> > Average:     1008      3001         -    0.00    0.18   51.54    3.23   50.12     -  qemu-system-ppc
> > Average:     1008         -      3001    0.02    0.02    0.00    0.00    0.00     -  |__qemu-system-ppc
> > Average:     1008         -      3003    0.00    0.03   15.89    0.99   48.24     -  |__qemu-system-ppc
> > Average:     1008         -      3004    0.00    0.05   11.70    0.73    0.56     -  |__qemu-system-ppc
> > Average:     1008         -      3005    0.00    0.06   20.03    1.26    0.58     -  |__qemu-system-ppc
> > Average:     1008         -      3006    0.00    0.03    3.93    0.25    0.72     -  |__qemu-system-ppc
> > 
> > 
> > On x86, we can obtain accurate steal time information since it is just the
> > scheduler run_delay. However, on powerpc, obtaining accurate steal time
> > information is challenging. This patchset proposes a technique that allows us
> > to obtain a reasonable (+/- 5%) approximation. Please suggest if there are
> > better ways to achieve more accurate steal time accounting in the hypervisor. I
> > am also interested in general feedback on the overall patchset and my approach
> > for the same.
> > 
> > 
> > Thanks!
> > - Naveen
> 
> When adding new interfaces regarding steal time etc, can you add the s390 list CC?
> s390 is doing steal time calculation also with hardware support: we have two type of
> timers, one compares agains the TOD clock, which steps with the wall clock, the other
> timer steps only if the guest CPU is backed by a real CPU. So, _IF_ this interface is
> introduced it would be good to have some s390 point of view included in that discussion.

Hi Christian,
Sure. I largely focused on powerpc and x86 so far. I will be glad to get 
feedback from s390 as well as other architectures on this.

Thanks,
Naveen
