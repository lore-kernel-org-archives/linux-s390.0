From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: Re: [PATCH net-next 3/4] s390/diag: add diag26c support
Date: Wed, 21 Jun 2017 17:30:44 +0200
Message-ID: <20170621173044.204bd2ca@mschwideX1>
References: <20170619112225.30471-4-jwi@linux.vnet.ibm.com>
        <20170619.104726.1778743929564587843.davem@davemloft.net>
        <20170619173425.4d537667@mschwideX1>
        <20170619.133743.1638444891079509192.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20170619.133743.1638444891079509192.davem@davemloft.net>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: jwi@linux.vnet.ibm.com, netdev@vger.kernel.org, linux-s390@vger.kernel.org, heiko.carstens@de.ibm.com, raspl@linux.vnet.ibm.com, ubraun@linux.vnet.ibm.com
List-ID: <linux-s390.vger.kernel.org>

Hi Dave,

On Mon, 19 Jun 2017 13:37:43 -0400 (EDT)
David Miller <davem@davemloft.net> wrote:

> From: Martin Schwidefsky <schwidefsky@de.ibm.com>
> Date: Mon, 19 Jun 2017 17:34:25 +0200
> 
> > We (as in the s390 guys) tend to add __packed to hardware and hypervisor
> > structures even if the attribute is not strictly necessary. Most of the
> > diagnose related structures look that way. Dunno if it is worth to change
> > them.  
> 
> It causes gcc to generate bad code on certain platforms (yes, probably not
> yours) and is in general something to avoid.
> 
> Please do not use __packed unless absolutely necessary.
> 
> > The diag26c struct needs to be aligned on a doubleword boundary, the
> > __aligned(8) is necessary.  
> 
> That's fine.
> 
> > The __packed attribute is again superfluous but follows along the
> > lines of the other diag structures.  
> 
> Please remove it.

I looked at the various structures with the packed attribute in arch/s390
and found that we could remove a lot of them. As __packed also changes the
alignment of the structure removing the attribute from structures defined
in arch/s390/include/uapi/asm may cause trouble in user space. I stayed
away from the uapi headers.

For the rest of the code about 120 packed attributes could be removed, see:

https://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git/log/?h=packed-cleanup

bloat-o-meter found only a few functions where the removal of packed
makes a difference (gcc 7.1.0):

add/remove: 1/1 grow/shrink: 8/7 up/down: 240/-308 (-68)
function                                     old     new   delta
pin_scb.isra                                   -     200    +200
stp_sync_clock                               982    1000     +18
stp_work_fn                                  416     420      +4
sca_ext_call_pending                         290     294      +4
kvm_arch_vcpu_create                        2008    2012      +4
get_vcpu_asce                               1206    1210      +4
hw_perf_event_update                        1738    1740      +2
clp_add_pci_device                          1400    1402      +2
__clp_rescan                                 162     164      +2
stp_timing_state_show                        138     134      -4
stp_timing_mode_show                         134     130      -4
stp_ctn_type_show                            134     130      -4
stp_time_offset_show                         150     144      -6
ccw_device_accumulate_irb                   1838    1832      -6
clp_misc_ioctl                              1142    1102     -40
timing_alert_interrupt                       158     114     -44
pin_scb                                      200       -    -200
Total: Before=155168810, After=155168742, chg -0.00%

The code gets minimally better. I am not convinced yet that this is worth
the hassle. These structures are architecture specific and the s390 CPUs
are perfectly fine with unaligned accesses.

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
