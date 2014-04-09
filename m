From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [PULL 0/8] KVM: s390: memory management and migration
Date: Wed, 09 Apr 2014 21:52:02 +0200
Message-ID: <5345A4E2.5090006@de.ibm.com>
References: <1397040298-59306-1-git-send-email-borntraeger@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1397040298-59306-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>, Gleb Natapov <gleb@kernel.org>
Cc: KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On 09/04/14 12:44, Christian Borntraeger wrote:
> Marcelo, Gleb, (Paolo,)
> 
> The following changes since commit 7cbb39d4d4d530dff12f2ff06ed6c85c504ba91a:
> 
>   Merge tag 'kvm-3.15-1' of git://git.kernel.org/pub/scm/virt/kvm/kvm (2014-04-02 14:50:10 -0700)
> 
> are available in the git repository at:
> 
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux.git  tags/kvm-s390-20140409
> 
> for you to fetch changes up to 384ee3e2a18893f9de84ce2f00cf786ad81fe08e:
> 
>   KVM: s390: Add proper dirty bitmap support to S390 kvm. (2014-04-09 11:12:15 +0200)
> 

The buildbot rightly complains about a link error for allnoconfig.
PULLv2 will follow shortly, with the following diff

--- a/arch/s390/mm/pgtable.c
+++ b/arch/s390/mm/pgtable.c
@@ -1022,6 +1022,11 @@ static inline unsigned long *page_table_alloc_pgste(struct mm_struct *mm,
        return NULL;
 }

+void page_table_reset_pgste(struct mm_struct *mm, unsigned long start,
+                           unsigned long end, bool init_skey)
+{
+}
+
 static inline void page_table_free_pgste(unsigned long *table)
 {
 }
