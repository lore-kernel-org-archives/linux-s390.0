From: David Hildenbrand <david@redhat.com>
Subject: Re: [RFC/PATCH v2 00/22] KVM/s390: Hugetlbfs enablement
Date: Mon, 22 Jan 2018 12:23:31 +0100
Message-ID: <4b9503c6-86dc-c120-8b25-e196037a7e6b@redhat.com>
References: <1513169613-13509-1-git-send-email-frankja@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1513169613-13509-1-git-send-email-frankja@linux.vnet.ibm.com>
Content-Language: en-US
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Janosch Frank <frankja@linux.vnet.ibm.com>, kvm@vger.kernel.org
Cc: schwidefsky@de.ibm.com, borntraeger@de.ibm.com, dominik.dingel@gmail.com, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On 13.12.2017 13:53, Janosch Frank wrote:
> Since the z10 s390 does support 1M pages, but whereas hugetlbfs
> support was added quite fast, KVM always used standard 4k pages for
> guest backings.
> 
> This patchset adds full support for 1M huge page backings for s390
> KVM guests. I.e. we also support VSIE (nested vms) for these guests
> and are therefore able to run all combinations of backings for all
> layers of guests.
> 
> When running a VSIE guest in a huge page backed guest, we need to
> split some huge pages to be able to set granular protection. This way
> we avoid a prot/unprot cycle if prefixes and VSIE pages containing
> level 3 gmap DAT tables share the same segment, as the prefix has to
> be accessible at all times and the VSIE page has to be write
> protected.
> 
> TODO:
> * Cleanups & Documentation
> * Refactoring to get rid of a lot of indents
> * Find a way to reduce or beautify bit checks on table entries
> * Storage key support for split pages (will be a separate bugfix)
> * Regression testing
> * Testing large setups
> * Testing multi level VSIE
> 
> V2:
> 	* Incorporated changes from David's cleanup
> 	* Now flushing with IDTE_NODAT for protection transfers.
> 	* Added RRBE huge page handling for g2 -> g3 skey emulation
> 	* Added documentation for capability
> 	* Renamed GMAP_ENTRY_* constants
> 	* Added SEGMENT hardware bits constants
> 	* Improved some patch descriptions
> 	* General small improvements
> 	* Introduced pte_from_pmd function
> 
> Accomplished testing:
> l2: KVM guest
> l3: nested KVM guest
> 
> * 1m l2 guests
> * VSIE (l3) 4k and 1m guests on 1m l2
> * 1m l2 -> l2 migration with 4k/1m l3 guests
> * l3 -> l2 migration
> * postcopy works every second try, seems to be QEMU or my setup
> 
> 
> The initial prototype was started by Dominik Dingel. I had the
> pleasure of adding the VSIE part, the protection transfers and the
> optimizations. A huge thanks to Christian and Martin who review(ed)
> and helped debugging/designing.
> 

Do you have a branch somewhere? I can't find a branch where this applies
cleanly. Thanks


-- 

Thanks,

David / dhildenb
