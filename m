From: Sachin Sant <sachinp@in.ibm.com>
Subject: next June 10: S390 build failure [arch/s390/kvm/kvm.ko]
Date: Thu, 10 Jun 2010 18:08:15 +0530
Message-ID: <4C10DCB7.7090903@in.ibm.com>
References: <20100610160012.30ea7606.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-next-owner@vger.kernel.org>
In-Reply-To: <20100610160012.30ea7606.sfr@canb.auug.org.au>
Sender: linux-next-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-next/>
List-Post: <mailto:linux-next@vger.kernel.org>
To: linux-next@vger.kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>, linux-s390@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Today's next fails to build on a s390 box with

ERROR: "__kvm_s390_vcpu_store_status" [arch/s390/kvm/kvm.ko] undefined!

Yesterday's next was good.

Thanks
-Sachin


-- 

---------------------------------
Sachin Sant
IBM Linux Technology Center
India Systems and Technology Labs
Bangalore, India
---------------------------------
