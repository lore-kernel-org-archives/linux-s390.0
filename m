Return-Path: <linux-kernel-owner@vger.kernel.org>
Message-Id: <20110216110118.316927092@linux.vnet.ibm.com>
Date: Wed, 16 Feb 2011 12:01:18 +0100
From: Heinz Graalfs <graalfs@linux.vnet.ibm.com>
Subject: [patch v2 0/3] s390 hw sampling rework on comments as of Feb 14th 
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: robert.richter@amd.com
Cc: mingo@elte.hu, oprofile-list@lists.sf.net, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, borntraeger@de.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com
List-ID: <linux-s390.vger.kernel.org>

Robert,

here is the second version of the rework for your comments as of February 14th.

v2:
   - oprofile_add_ext_sample.patch
         - introduces struct oprofile_sample_parms in include/linux/oprofile.h
         - merges oprofile_add_ext_hw_sample() into oprofile_add_ext_sample()
         - changes signature of oprofile_add_ext_sample() by using the proposed
           structure containing relevant parameters
         - changes all references of oprofile_add_ext_sample()

v1:
   - oprofile_merge_init.patch
         - merges hwsampler_files.c of arch/s390/oprofile into init.c

   - oprofile_parms_struct.patch
         - introduces first version of struct oprofile_sample_parms in various
           functions

Heinz
