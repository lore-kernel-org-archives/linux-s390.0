From: David Hildenbrand <david@redhat.com>
Subject: Re: [RFC/PATCH v2 00/22] KVM/s390: Hugetlbfs enablement
Date: Tue, 23 Jan 2018 22:15:35 +0100
Message-ID: <8f1ca87d-eb66-1b88-5ef1-0123e04bc565@redhat.com>
References: <1513169613-13509-1-git-send-email-frankja@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
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

Please correct me if I'm wrong (this stuff is complicated):


Right now we have to split huge pages under the following condition:

a) We are write protecting (prot != PROT_WRITE) ...
b) ... and we are doing it during shadow page table creation
(GMAP_NOTIFY_SHADOW)

-> gmap_protect_pmd()


This is to work around issues (RW vs. RO) when
a) G2 puts G2->G3 DAT tables on same huge page as a G2 prefix
b) Guest G2->G3 DAT tables on same huge page as G2->G3 pages referenced
in such a table

"we cannot have RO and RW at the same time if things depend on each other".


Now, the interesting thing is, for shadow page tables
(GMAP_NOTIFY_SHADOW), we only protect RO: via gmap_protect_rmap() and
gmap_protect_range().

So basically for all shadow page table housekeeping, we never protect on
pmds but only on ptes. -> We always split huge pages

This implies and important insight: _SEGMENT_ENTRY_GMAP_VSIE is never
used. (and I will prepare a cleanup patch to make PROT_READ implicit on
e.g. gmap_protect_rmap(), because this clarifies this a lot)


We only ever protect right now on huge pages without splitting it up for
the prefix, as I already mentioned. And as discussed, I doubt this is
really worth it. And we can get rid of a lot of code this way.


Long story short:

If we simply split up huge pages when protecting the prefix, we don't
need gmap_protect_pmd() anymore, and therefore also (at least) not

- s390/mm: Abstract gmap notify bit setting
- s390/mm: add gmap PMD invalidation notification


So I think doing proper sub-hugepage protection right from the beginning
makes perfect sense.

@Martin, Christian, am I missing something? What's your take on this?

-- 

Thanks,

David / dhildenb
