From: Thomas Huth <thuth@redhat.com>
Date: Mon, 21 Jan 2019 10:52:53 +0000
Subject: Re: [kvm-unit-tests PATCH v6 00/11] s390x: Add cross hypervisor and disk boot
Message-Id: <681154ac-dcc2-2324-4806-424dac8552fa@redhat.com>
In-Reply-To: <20190118114204.147868-1-frankja@linux.ibm.com>
References: <20190118114204.147868-1-frankja@linux.ibm.com>
To: linux-s390@vger.kernel.org, kvm@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On 2019-01-18 12:41, Janosch Frank wrote:
> With these patches kvm unit tests are now bootable under LPAR and
> z/VM, as well as from KVM disks.
> 
> For this to work we added:
>     * Initial PSW in lowcore
>     * Switch to 64 bit and z/Arch
>     * SCLP linemode console
>     * Binary generation in Makefile
> 
> v6:
> 	* Added linemode sclp loop to print large strings
> 	* Fixed sclp read info locking
> 	* commit message fixups
> 
> v5:
> 	* Cleaned up linemode
> 	* Minor fixups and squash of sclp int and lock patches
> 	* Removed time patches, added phys alloc setup
> 
> v4:
> 	* Added sigp header file
> 	* Moved clearing to xgr instead of lm
> 	* Minor renames, comment additions
> 
> v3:
> 	* Rebased on David's SCLP fixes
> 	* Added binary generation make command
> 	* Split up cleanup and sclp common movement
> 	* Fixed whitespace problems
> 	* Added more comments
> 	* Added linemode buffer to get rid of line splits
> 
> v2:
> 	* Moved cleanup to the front and broadened patch
> 	* Split up SCLP patch into interrupt and linemode
> 	* Removed unneeded instructions
> 	* Improved comments and commit messages
> 
> 
> Janosch Frank (11):
>   s390x: Add Sigp header file
>   s390x: Rename and cleanup sclp-ascii.c
>   s390x: Make tests bootable from disk
>   s390x: Switch to z/Arch and enable 64 bit addressing mode
>   s390x: Add BSS clearing for non ELF boot
>   s390x: Move common sclp data and functions to sclp.c
>   s390x: Use interrupts in SCLP and add locking
>   s390x: Add linemode console
>   s390x: Add linemode buffer to fix newline on every print
>   s390x: Add binary generation to makefile
>   s390x: Initialize the physical allocator on mem init

Ok, for the records: I've picked up patche 1 - 6 and 10 and 11 ... the
other three likely need some more rework as David mentioned in his review.

 Thomas
