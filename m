From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH 0/1] suspend/resume for virtio_ccw
Date: Thu,  7 Dec 2017 15:11:01 +0100
Message-ID: <20171207141102.70190-1-borntraeger@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Halil Pasic <pasic@linux.vnet.ibm.com>, Cornelia Huck <cohuck@redhat.com>
Cc: linux-s390@vger.kernel.org, Thomas Huth <thuth@redhat.com>, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-ID: <linux-s390.vger.kernel.org>

With this patch I can suspend/resume a KVM guest.

[root@test ~]# cd /sys/power/
[root@test power]# echo test_resume > disk
[root@test power]# lscss 
Device   Subchan.  DevType CU Type Use  PIM PAM POM  CHPIDs           
----------------------------------------------------------------------
0.0.0003 0.0.0000  0000/00 3832/03 yes  80  80  ff   00000000 00000000
0.0.0000 0.0.0001  0000/00 3832/02 yes  80  80  ff   00000000 00000000
0.0.0001 0.0.0002  0000/00 3832/02 yes  80  80  ff   00000000 00000000
0.0.0004 0.0.0003  0000/00 3832/02 yes  80  80  ff   00000000 00000000
0.0.0005 0.0.0004  0000/00 3832/02 yes  80  80  ff   00000000 00000000
0.0.0006 0.0.0005  0000/00 3832/02 yes  80  80  ff   00000000 00000000
0.0.0007 0.0.0006  0000/00 3832/02 yes  80  80  ff   00000000 00000000
0.0.0008 0.0.0007  0000/00 3832/02 yes  80  80  ff   00000000 00000000
0.0.0009 0.0.0008  0000/00 3832/02 yes  80  80  ff   00000000 00000000
0.0.000a 0.0.0009  0000/00 3832/02 yes  80  80  ff   00000000 00000000
0.0.000b 0.0.000a  0000/00 3832/02 yes  80  80  ff   00000000 00000000
0.0.000c 0.0.000b  0000/00 3832/02 yes  80  80  ff   00000000 00000000
0.0.000e 0.0.000c  0000/00 3832/02 yes  80  80  ff   00000000 00000000
0.0.000f 0.0.000d  0000/00 3832/02 yes  80  80  ff   00000000 00000000
0.0.0010 0.0.000e  0000/00 3832/02 yes  80  80  ff   00000000 00000000
0.0.0011 0.0.000f  0000/00 3832/02 yes  80  80  ff   00000000 00000000
0.0.0012 0.0.0010  0000/00 3832/02 yes  80  80  ff   00000000 00000000
0.0.0013 0.0.0011  0000/00 3832/02 yes  80  80  ff   00000000 00000000
0.0.0014 0.0.0012  0000/00 3832/02 yes  80  80  ff   00000000 00000000
0.0.0002 0.0.0013  0000/00 3832/09 yes  80  80  ff   00000000 00000000
0.0.000d 0.0.0014  0000/00 3832/01 yes  80  80  ff   00000000 00000000
0.0.0015 0.0.0015  0000/00 3832/02 yes  80  80  ff   00000000 00000000
0.0.0016 0.0.0016  0000/00 3832/02 yes  80  80  ff   00000000 00000000
0.0.0017 0.0.0017  0000/00 3832/02 yes  80  80  ff   00000000 00000000
0.0.0018 0.0.0018  0000/00 3832/02 yes  80  80  ff   00000000 00000000
0.0.0019 0.0.0019  0000/00 3832/02 yes  80  80  ff   00000000 00000000
0.3.ffba 0.3.0000  0000/00 3832/05 yes  80  80  ff   00000000 00000000
[root@test power]# echo disk > state
[  195.854629] PM: hibernation entry
[  195.854780] PM: Syncing filesystems ... 
[  195.855837] PM: done.
[  195.855839] Freezing user space processes ... (elapsed 0.001 seconds) done.
[  195.856927] OOM killer disabled.
[  195.856941] PM: Preallocating image memory... done (allocated 182918 pages)
[  196.229494] PM: Allocated 731672 kbytes in 0.37 seconds (1977.49 MB/s)
[  196.229495] Freezing remaining freezable tasks ... (elapsed 0.002 seconds) done.
[  196.231772] Suspending console(s) (use no_console_suspend to debug)
[  196.238620] Disabling non-boot CPUs ...
[  196.238632] PM: Creating hibernation image:
[  196.267113] PM: Need to copy 182169 pages
[  196.892074] PM: Hibernation image created (182169 pages copied)
[  196.905127] PM: Using 1 thread(s) for compression.
[  196.905127] PM: Compressing and saving image data (182525 pages)...
[  197.358550] PM: Image saving progress:   0%
[  197.595283] PM: Image saving progress:  10%
[  197.740148] PM: Image saving progress:  20%
[  197.859172] PM: Image saving progress:  30%
[  197.989838] PM: Image saving progress:  40%
[  198.100692] PM: Image saving progress:  50%
[  198.205154] PM: Image saving progress:  60%
[  198.308987] PM: Image saving progress:  70%
[  198.412584] PM: Image saving progress:  80%
[  198.516285] PM: Image saving progress:  90%
[  198.620025] PM: Image saving progress: 100%
[  198.620176] PM: Image saving done.
[  198.620178] PM: Wrote 730100 kbytes in 1.71 seconds (426.95 MB/s)
[  198.620256] PM: S
[  198.620323] |
[  198.650677] PM: Using 1 thread(s) for decompression.
[  198.650677] PM: Loading and decompressing image data (182525 pages)...
[  198.663329] PM: Image loading progress:   0%
[  198.990431] PM: Image loading progress:  10%
[  199.155921] PM: Image loading progress:  20%
[  199.317973] PM: Image loading progress:  30%
[  199.457977] PM: Image loading progress:  40%
[  199.614798] PM: Image loading progress:  50%
[  199.843670] PM: Image loading progress:  60%
[  200.075105] PM: Image loading progress:  70%
[  200.307333] PM: Image loading progress:  80%
[  200.540000] PM: Image loading progress:  90%
[  195.856941] PM: Preallocating image memory... done (allocated 182918 pages)
[  196.229494] PM: Allocated 731672 kbytes in 0.37 seconds (1977.49 MB/s)
[  196.229495] Freezing remaining freezable tasks ... (elapsed 0.002 seconds) done.
[  196.231772] Suspending console(s) (use no_console_suspend to debug)
[  196.238620] Disabling non-boot CPUs ...
[  196.238632] PM: Creating hibernation image:
[  196.267113] PM: Need to copy 182169 pages
[  201.314326] OOM killer enabled.
[  201.314327] Restarting tasks ... done.
[  201.315976] PM: hibernation exit
[root@test power]# lscss 
Device   Subchan.  DevType CU Type Use  PIM PAM POM  CHPIDs           
----------------------------------------------------------------------
0.0.0003 0.0.0000  0000/00 3832/03 yes  80  80  ff   00000000 00000000
0.0.0000 0.0.0001  0000/00 3832/02 yes  80  80  ff   00000000 00000000
0.0.0001 0.0.0002  0000/00 3832/02 yes  80  80  ff   00000000 00000000
0.0.0004 0.0.0003  0000/00 3832/02 yes  80  80  ff   00000000 00000000
0.0.0005 0.0.0004  0000/00 3832/02 yes  80  80  ff   00000000 00000000
0.0.0006 0.0.0005  0000/00 3832/02 yes  80  80  ff   00000000 00000000
0.0.0007 0.0.0006  0000/00 3832/02 yes  80  80  ff   00000000 00000000
0.0.0008 0.0.0007  0000/00 3832/02 yes  80  80  ff   00000000 00000000
0.0.0009 0.0.0008  0000/00 3832/02 yes  80  80  ff   00000000 00000000
0.0.000a 0.0.0009  0000/00 3832/02 yes  80  80  ff   00000000 00000000
0.0.000b 0.0.000a  0000/00 3832/02 yes  80  80  ff   00000000 00000000
0.0.000c 0.0.000b  0000/00 3832/02 yes  80  80  ff   00000000 00000000
0.0.000e 0.0.000c  0000/00 3832/02 yes  80  80  ff   00000000 00000000
0.0.000f 0.0.000d  0000/00 3832/02 yes  80  80  ff   00000000 00000000
0.0.0010 0.0.000e  0000/00 3832/02 yes  80  80  ff   00000000 00000000
0.0.0011 0.0.000f  0000/00 3832/02 yes  80  80  ff   00000000 00000000
0.0.0012 0.0.0010  0000/00 3832/02 yes  80  80  ff   00000000 00000000
0.0.0013 0.0.0011  0000/00 3832/02 yes  80  80  ff   00000000 00000000
0.0.0014 0.0.0012  0000/00 3832/02 yes  80  80  ff   00000000 00000000
0.0.0002 0.0.0013  0000/00 3832/09 yes  80  80  ff   00000000 00000000
0.0.000d 0.0.0014  0000/00 3832/01 yes  80  80  ff   00000000 00000000
0.0.0015 0.0.0015  0000/00 3832/02 yes  80  80  ff   00000000 00000000
0.0.0016 0.0.0016  0000/00 3832/02 yes  80  80  ff   00000000 00000000
0.0.0017 0.0.0017  0000/00 3832/02 yes  80  80  ff   00000000 00000000
0.0.0018 0.0.0018  0000/00 3832/02 yes  80  80  ff   00000000 00000000
0.0.0019 0.0.0019  0000/00 3832/02 yes  80  80  ff   00000000 00000000
0.3.ffba 0.3.0000  0000/00 3832/05 yes  80  80  ff   00000000 00000000
[root@test power]# 


Christian Borntraeger (1):
  virtio/s390: implement PM operations for virtio_ccw

 drivers/s390/virtio/virtio_ccw.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

-- 
2.9.4
