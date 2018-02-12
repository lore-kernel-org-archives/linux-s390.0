Return-Path: <mhocko@kernel.org>
Date: Mon, 12 Feb 2018 14:37:32 +0100
From: Michal Hocko <mhocko@kernel.org>
Subject: samples/seccomp/ broken when cross compiling s390, ppc allyesconfig
Message-ID: <20180212133731.GE3443@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="9jxsPFA5p3P2qPhR"
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>
To: Will Drewry <wad@chromium.org>
Cc: LKML <linux-kernel@vger.kernel.org>, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>


--9jxsPFA5p3P2qPhR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,
my build test machinery chokes on samples/seccomp when cross compiling
s390 and ppc64 allyesconfig. This has been the case for quite some
time already but I never found time to look at the problem and report
it. It seems this is not new issue and similar thing happend for
MIPS e9107f88c985 ("samples/seccomp/Makefile: do not build tests if
cross-compiling for MIPS").

The build logs are attached.

What is the best way around this? Should we simply skip compilation on
cross compile or is actually anybody relying on that? Or should I simply
disable it for s390 and ppc?
-- 
Michal Hocko
SUSE Labs

--9jxsPFA5p3P2qPhR
Content-Type: text/plain; charset="utf-8"
Content-Disposition: attachment; filename="s390-20180201_102415.log"
Content-Transfer-Encoding: 8bit

=== Config /home/mhocko/work/build-test/configs/s390/allyesconfig
security/integrity/ima/ima_api.c: In function 'ima_audit_measurement':
security/integrity/ima/ima_api.c:337:1: warning: 'ima_audit_measurement' uses dynamic stack allocation
 }
 ^
arch/s390/crypto/aes_s390.c: In function 'fallback_blk_dec':
arch/s390/crypto/aes_s390.c:217:1: warning: 'fallback_blk_dec' uses dynamic stack allocation
 }
 ^
arch/s390/crypto/aes_s390.c: In function 'fallback_blk_enc':
arch/s390/crypto/aes_s390.c:234:1: warning: 'fallback_blk_enc' uses dynamic stack allocation
 }
 ^
arch/s390/crypto/aes_s390.c: In function 'xts_aes_decrypt':
arch/s390/crypto/aes_s390.c:607:1: warning: 'xts_aes_decrypt' uses dynamic stack allocation
 }
 ^
arch/s390/crypto/aes_s390.c: In function 'xts_aes_encrypt':
arch/s390/crypto/aes_s390.c:593:1: warning: 'xts_aes_encrypt' uses dynamic stack allocation
 }
 ^
security/integrity/ima/ima_crypto.c: In function 'ima_calc_field_array_hash_tfm.isra.3':
security/integrity/ima/ima_crypto.c:491:1: warning: 'ima_calc_field_array_hash_tfm.isra.3' uses dynamic stack allocation
 }
 ^
security/integrity/ima/ima_crypto.c: In function 'ima_calc_file_hash':
security/integrity/ima/ima_crypto.c:441:1: warning: 'ima_calc_file_hash' uses dynamic stack allocation
 }
 ^
security/integrity/ima/ima_crypto.c: In function 'ima_calc_buffer_hash':
security/integrity/ima/ima_crypto.c:628:1: warning: 'ima_calc_buffer_hash' uses dynamic stack allocation
 }
 ^
security/integrity/ima/ima_crypto.c: In function 'ima_calc_boot_aggregate':
security/integrity/ima/ima_crypto.c:682:1: warning: 'ima_calc_boot_aggregate' uses dynamic stack allocation
 }
 ^
security/keys/dh.c: In function 'keyctl_dh_compute_kdf':
security/keys/dh.c:237:1: warning: 'keyctl_dh_compute_kdf' uses dynamic stack allocation
 }
 ^
security/keys/big_key.c: In function 'big_key_crypt':
security/keys/big_key.c:130:1: warning: 'big_key_crypt' uses dynamic stack allocation
 }
 ^
security/apparmor/crypto.c: In function 'aa_calc_hash':
security/apparmor/crypto.c:64:1: warning: 'aa_calc_hash' uses dynamic stack allocation
 }
 ^
security/apparmor/crypto.c: In function 'aa_calc_profile_hash':
security/apparmor/crypto.c:106:1: warning: 'aa_calc_profile_hash' uses dynamic stack allocation
 }
 ^
security/keys/encrypted-keys/encrypted.c: In function 'calc_hash':
security/keys/encrypted-keys/encrypted.c:337:1: warning: 'calc_hash' uses dynamic stack allocation
 }
 ^
crypto/cipher.c: In function 'cipher_crypt_unaligned':
crypto/cipher.c:76:1: warning: 'cipher_crypt_unaligned' uses dynamic stack allocation
 }
 ^
drivers/android/binder_alloc.c: In function 'binder_alloc_shrinker_init':
drivers/android/binder_alloc.c:1008:2: warning: ignoring return value of 'register_shrinker', declared with attribute warn_unused_result [-Wunused-result]
  register_shrinker(&binder_shrinker);
  ^
drivers/gpio/gpiolib.c: In function 'gpiod_get_array_value_complex':
drivers/gpio/gpiolib.c:2644:1: warning: 'gpiod_get_array_value_complex' uses dynamic stack allocation
 }
 ^
drivers/gpio/gpiolib.c: In function 'gpiod_set_array_value_complex':
drivers/gpio/gpiolib.c:2873:1: warning: 'gpiod_set_array_value_complex' uses dynamic stack allocation
 }
 ^
drivers/atm/ambassador.c: In function 'do_loader_command':
drivers/atm/ambassador.c:1762:45: warning: passing argument 1 of 'virt_to_bus' discards 'volatile' qualifier from pointer target type
   wr_mem (dev, offsetof(amb_mem, doorbell), virt_to_bus (lb) & ~onegigmask);
                                             ^
In file included from ./arch/s390/include/asm/io.h:79:0,
                 from ./include/linux/io.h:25,
                 from ./include/linux/pci.h:33,
                 from drivers/atm/ambassador.c:27:
./include/asm-generic/io.h:946:29: note: expected 'void *' but argument is of type 'volatile struct loader_block *'
 static inline unsigned long virt_to_bus(void *address)
                             ^
In file included from samples/seccomp/bpf-fancy.c:21:0:
samples/seccomp/bpf-helper.h:135:2: error: #error __BITS_PER_LONG value unusable.
 #error __BITS_PER_LONG value unusable.
  ^
In file included from samples/seccomp/bpf-fancy.c:13:0:
samples/seccomp/bpf-fancy.c: In function ‘main’:
samples/seccomp/bpf-fancy.c:38:11: error: ‘__NR_exit’ undeclared (first use in this function)
   SYSCALL(__NR_exit, ALLOW),
           ^
./usr/include/linux/filter.h:52:69: note: in definition of macro ‘BPF_JUMP’
 #define BPF_JUMP(code, k, jt, jf) { (unsigned short)(code), jt, jf, k }
                                                                     ^
samples/seccomp/bpf-fancy.c:38:3: note: in expansion of macro ‘SYSCALL’
   SYSCALL(__NR_exit, ALLOW),
   ^
samples/seccomp/bpf-fancy.c:38:11: note: each undeclared identifier is reported only once for each function it appears in
   SYSCALL(__NR_exit, ALLOW),
           ^
./usr/include/linux/filter.h:52:69: note: in definition of macro ‘BPF_JUMP’
 #define BPF_JUMP(code, k, jt, jf) { (unsigned short)(code), jt, jf, k }
                                                                     ^
samples/seccomp/bpf-fancy.c:38:3: note: in expansion of macro ‘SYSCALL’
   SYSCALL(__NR_exit, ALLOW),
   ^
samples/seccomp/bpf-fancy.c:39:11: error: ‘__NR_exit_group’ undeclared (first use in this function)
   SYSCALL(__NR_exit_group, ALLOW),
           ^
./usr/include/linux/filter.h:52:69: note: in definition of macro ‘BPF_JUMP’
 #define BPF_JUMP(code, k, jt, jf) { (unsigned short)(code), jt, jf, k }
                                                                     ^
samples/seccomp/bpf-fancy.c:39:3: note: in expansion of macro ‘SYSCALL’
   SYSCALL(__NR_exit_group, ALLOW),
   ^
samples/seccomp/bpf-fancy.c:40:11: error: ‘__NR_write’ undeclared (first use in this function)
   SYSCALL(__NR_write, JUMP(&l, write_fd)),
           ^
./usr/include/linux/filter.h:52:69: note: in definition of macro ‘BPF_JUMP’
 #define BPF_JUMP(code, k, jt, jf) { (unsigned short)(code), jt, jf, k }
                                                                     ^
samples/seccomp/bpf-fancy.c:40:3: note: in expansion of macro ‘SYSCALL’
   SYSCALL(__NR_write, JUMP(&l, write_fd)),
   ^
samples/seccomp/bpf-fancy.c:41:11: error: ‘__NR_read’ undeclared (first use in this function)
   SYSCALL(__NR_read, JUMP(&l, read)),
           ^
./usr/include/linux/filter.h:52:69: note: in definition of macro ‘BPF_JUMP’
 #define BPF_JUMP(code, k, jt, jf) { (unsigned short)(code), jt, jf, k }
                                                                     ^
samples/seccomp/bpf-fancy.c:41:3: note: in expansion of macro ‘SYSCALL’
   SYSCALL(__NR_read, JUMP(&l, read)),
   ^
samples/seccomp/bpf-fancy.c:45:3: warning: implicit declaration of function ‘ARG’ [-Wimplicit-function-declaration]
   ARG(0),
   ^
samples/seccomp/bpf-fancy.c:45:3: warning: missing braces around initializer [-Wmissing-braces]
samples/seccomp/bpf-fancy.c:45:3: warning: (near initialization for ‘filter[11]’) [-Wmissing-braces]
samples/seccomp/bpf-fancy.c:46:3: warning: implicit declaration of function ‘JNE’ [-Wimplicit-function-declaration]
   JNE(STDIN_FILENO, DENY),
   ^
In file included from samples/seccomp/bpf-fancy.c:13:0:
./usr/include/linux/filter.h:49:27: error: expected expression before ‘{’ token
 #define BPF_STMT(code, k) { (unsigned short)(code), 0, 0, k }
                           ^
samples/seccomp/bpf-helper.h:48:2: note: in expansion of macro ‘BPF_STMT’
  BPF_STMT(BPF_RET+BPF_K, SECCOMP_RET_KILL)
  ^
samples/seccomp/bpf-fancy.c:46:21: note: in expansion of macro ‘DENY’
   JNE(STDIN_FILENO, DENY),
                     ^
./usr/include/linux/filter.h:49:27: error: expected expression before ‘{’ token
 #define BPF_STMT(code, k) { (unsigned short)(code), 0, 0, k }
                           ^
samples/seccomp/bpf-helper.h:48:2: note: in expansion of macro ‘BPF_STMT’
  BPF_STMT(BPF_RET+BPF_K, SECCOMP_RET_KILL)
  ^
samples/seccomp/bpf-fancy.c:48:27: note: in expansion of macro ‘DENY’
   JNE((unsigned long)buf, DENY),
                           ^
samples/seccomp/bpf-fancy.c:50:3: warning: implicit declaration of function ‘JGE’ [-Wimplicit-function-declaration]
   JGE(sizeof(buf), DENY),
   ^
In file included from samples/seccomp/bpf-fancy.c:13:0:
./usr/include/linux/filter.h:49:27: error: expected expression before ‘{’ token
 #define BPF_STMT(code, k) { (unsigned short)(code), 0, 0, k }
                           ^
samples/seccomp/bpf-helper.h:48:2: note: in expansion of macro ‘BPF_STMT’
  BPF_STMT(BPF_RET+BPF_K, SECCOMP_RET_KILL)
  ^
samples/seccomp/bpf-fancy.c:50:20: note: in expansion of macro ‘DENY’
   JGE(sizeof(buf), DENY),
                    ^
samples/seccomp/bpf-fancy.c:51:3: warning: braces around scalar initializer [enabled by default]
   ALLOW,
   ^
samples/seccomp/bpf-fancy.c:51:3: warning: (near initialization for ‘filter[12].jf’) [enabled by default]
samples/seccomp/bpf-fancy.c:51:3: warning: excess elements in scalar initializer [enabled by default]
samples/seccomp/bpf-fancy.c:51:3: warning: (near initialization for ‘filter[12].jf’) [enabled by default]
samples/seccomp/bpf-fancy.c:51:3: warning: excess elements in scalar initializer [enabled by default]
samples/seccomp/bpf-fancy.c:51:3: warning: (near initialization for ‘filter[12].jf’) [enabled by default]
samples/seccomp/bpf-fancy.c:51:3: warning: excess elements in scalar initializer [enabled by default]
samples/seccomp/bpf-fancy.c:51:3: warning: (near initialization for ‘filter[12].jf’) [enabled by default]
samples/seccomp/bpf-fancy.c:53:3: warning: braces around scalar initializer [enabled by default]
   LABEL(&l, write_fd),
   ^
samples/seccomp/bpf-fancy.c:53:3: warning: (near initialization for ‘filter[12].k’) [enabled by default]
samples/seccomp/bpf-fancy.c:53:3: warning: excess elements in scalar initializer [enabled by default]
samples/seccomp/bpf-fancy.c:53:3: warning: (near initialization for ‘filter[12].k’) [enabled by default]
samples/seccomp/bpf-fancy.c:53:3: warning: excess elements in scalar initializer [enabled by default]
samples/seccomp/bpf-fancy.c:53:3: warning: (near initialization for ‘filter[12].k’) [enabled by default]
samples/seccomp/bpf-fancy.c:53:3: warning: excess elements in scalar initializer [enabled by default]
samples/seccomp/bpf-fancy.c:53:3: warning: (near initialization for ‘filter[12].k’) [enabled by default]
samples/seccomp/bpf-fancy.c:55:3: warning: implicit declaration of function ‘JEQ’ [-Wimplicit-function-declaration]
   JEQ(STDOUT_FILENO, JUMP(&l, write_buf)),
   ^
In file included from samples/seccomp/bpf-fancy.c:13:0:
./usr/include/linux/filter.h:52:35: error: expected expression before ‘{’ token
 #define BPF_JUMP(code, k, jt, jf) { (unsigned short)(code), jt, jf, k }
                                   ^
samples/seccomp/bpf-helper.h:50:2: note: in expansion of macro ‘BPF_JUMP’
  BPF_JUMP(BPF_JMP+BPF_JA, FIND_LABEL((labels), (label)), \
  ^
samples/seccomp/bpf-fancy.c:55:22: note: in expansion of macro ‘JUMP’
   JEQ(STDOUT_FILENO, JUMP(&l, write_buf)),
                      ^
./usr/include/linux/filter.h:52:35: error: expected expression before ‘{’ token
 #define BPF_JUMP(code, k, jt, jf) { (unsigned short)(code), jt, jf, k }
                                   ^
samples/seccomp/bpf-helper.h:50:2: note: in expansion of macro ‘BPF_JUMP’
  BPF_JUMP(BPF_JMP+BPF_JA, FIND_LABEL((labels), (label)), \
  ^
samples/seccomp/bpf-fancy.c:56:22: note: in expansion of macro ‘JUMP’
   JEQ(STDERR_FILENO, JUMP(&l, write_buf)),
                      ^
samples/seccomp/bpf-fancy.c:57:3: warning: braces around scalar initializer [enabled by default]
   DENY,
   ^
samples/seccomp/bpf-fancy.c:57:3: warning: (near initialization for ‘filter[13].k’) [enabled by default]
samples/seccomp/bpf-fancy.c:57:3: warning: excess elements in scalar initializer [enabled by default]
samples/seccomp/bpf-fancy.c:57:3: warning: (near initialization for ‘filter[13].k’) [enabled by default]
samples/seccomp/bpf-fancy.c:57:3: warning: excess elements in scalar initializer [enabled by default]
samples/seccomp/bpf-fancy.c:57:3: warning: (near initialization for ‘filter[13].k’) [enabled by default]
samples/seccomp/bpf-fancy.c:57:3: warning: excess elements in scalar initializer [enabled by default]
samples/seccomp/bpf-fancy.c:57:3: warning: (near initialization for ‘filter[13].k’) [enabled by default]
In file included from samples/seccomp/bpf-fancy.c:13:0:
./usr/include/linux/filter.h:52:35: error: expected expression before ‘{’ token
 #define BPF_JUMP(code, k, jt, jf) { (unsigned short)(code), jt, jf, k }
                                   ^
samples/seccomp/bpf-helper.h:50:2: note: in expansion of macro ‘BPF_JUMP’
  BPF_JUMP(BPF_JMP+BPF_JA, FIND_LABEL((labels), (label)), \
  ^
samples/seccomp/bpf-fancy.c:61:28: note: in expansion of macro ‘JUMP’
   JEQ((unsigned long)msg1, JUMP(&l, msg1_len)),
                            ^
./usr/include/linux/filter.h:52:35: error: expected expression before ‘{’ token
 #define BPF_JUMP(code, k, jt, jf) { (unsigned short)(code), jt, jf, k }
                                   ^
samples/seccomp/bpf-helper.h:50:2: note: in expansion of macro ‘BPF_JUMP’
  BPF_JUMP(BPF_JMP+BPF_JA, FIND_LABEL((labels), (label)), \
  ^
samples/seccomp/bpf-fancy.c:62:28: note: in expansion of macro ‘JUMP’
   JEQ((unsigned long)msg2, JUMP(&l, msg2_len)),
                            ^
./usr/include/linux/filter.h:52:35: error: expected expression before ‘{’ token
 #define BPF_JUMP(code, k, jt, jf) { (unsigned short)(code), jt, jf, k }
                                   ^
samples/seccomp/bpf-helper.h:50:2: note: in expansion of macro ‘BPF_JUMP’
  BPF_JUMP(BPF_JMP+BPF_JA, FIND_LABEL((labels), (label)), \
  ^
samples/seccomp/bpf-fancy.c:63:27: note: in expansion of macro ‘JUMP’
   JEQ((unsigned long)buf, JUMP(&l, buf_len)),
                           ^
samples/seccomp/bpf-fancy.c:68:3: warning: implicit declaration of function ‘JLT’ [-Wimplicit-function-declaration]
   JLT(sizeof(msg1), ALLOW),
   ^
In file included from samples/seccomp/bpf-fancy.c:13:0:
./usr/include/linux/filter.h:49:27: error: expected expression before ‘{’ token
 #define BPF_STMT(code, k) { (unsigned short)(code), 0, 0, k }
                           ^
samples/seccomp/bpf-helper.h:46:2: note: in expansion of macro ‘BPF_STMT’
  BPF_STMT(BPF_RET+BPF_K, SECCOMP_RET_ALLOW)
  ^
samples/seccomp/bpf-fancy.c:68:21: note: in expansion of macro ‘ALLOW’
   JLT(sizeof(msg1), ALLOW),
                     ^
samples/seccomp/bpf-fancy.c:69:3: warning: braces around scalar initializer [enabled by default]
   DENY,
   ^
samples/seccomp/bpf-fancy.c:69:3: warning: (near initialization for ‘filter[18].jf’) [enabled by default]
samples/seccomp/bpf-fancy.c:69:3: warning: excess elements in scalar initializer [enabled by default]
samples/seccomp/bpf-fancy.c:69:3: warning: (near initialization for ‘filter[18].jf’) [enabled by default]
samples/seccomp/bpf-fancy.c:69:3: warning: excess elements in scalar initializer [enabled by default]
samples/seccomp/bpf-fancy.c:69:3: warning: (near initialization for ‘filter[18].jf’) [enabled by default]
samples/seccomp/bpf-fancy.c:69:3: warning: excess elements in scalar initializer [enabled by default]
samples/seccomp/bpf-fancy.c:69:3: warning: (near initialization for ‘filter[18].jf’) [enabled by default]
samples/seccomp/bpf-fancy.c:71:3: warning: braces around scalar initializer [enabled by default]
   LABEL(&l, msg2_len),
   ^
samples/seccomp/bpf-fancy.c:71:3: warning: (near initialization for ‘filter[18].k’) [enabled by default]
samples/seccomp/bpf-fancy.c:71:3: warning: excess elements in scalar initializer [enabled by default]
samples/seccomp/bpf-fancy.c:71:3: warning: (near initialization for ‘filter[18].k’) [enabled by default]
samples/seccomp/bpf-fancy.c:71:3: warning: excess elements in scalar initializer [enabled by default]
samples/seccomp/bpf-fancy.c:71:3: warning: (near initialization for ‘filter[18].k’) [enabled by default]
samples/seccomp/bpf-fancy.c:71:3: warning: excess elements in scalar initializer [enabled by default]
samples/seccomp/bpf-fancy.c:71:3: warning: (near initialization for ‘filter[18].k’) [enabled by default]
In file included from samples/seccomp/bpf-fancy.c:13:0:
./usr/include/linux/filter.h:49:27: error: expected expression before ‘{’ token
 #define BPF_STMT(code, k) { (unsigned short)(code), 0, 0, k }
                           ^
samples/seccomp/bpf-helper.h:46:2: note: in expansion of macro ‘BPF_STMT’
  BPF_STMT(BPF_RET+BPF_K, SECCOMP_RET_ALLOW)
  ^
samples/seccomp/bpf-fancy.c:73:21: note: in expansion of macro ‘ALLOW’
   JLT(sizeof(msg2), ALLOW),
                     ^
samples/seccomp/bpf-fancy.c:74:3: warning: braces around scalar initializer [enabled by default]
   DENY,
   ^
samples/seccomp/bpf-fancy.c:74:3: warning: (near initialization for ‘filter[19].jf’) [enabled by default]
samples/seccomp/bpf-fancy.c:74:3: warning: excess elements in scalar initializer [enabled by default]
samples/seccomp/bpf-fancy.c:74:3: warning: (near initialization for ‘filter[19].jf’) [enabled by default]
samples/seccomp/bpf-fancy.c:74:3: warning: excess elements in scalar initializer [enabled by default]
samples/seccomp/bpf-fancy.c:74:3: warning: (near initialization for ‘filter[19].jf’) [enabled by default]
samples/seccomp/bpf-fancy.c:74:3: warning: excess elements in scalar initializer [enabled by default]
samples/seccomp/bpf-fancy.c:74:3: warning: (near initialization for ‘filter[19].jf’) [enabled by default]
samples/seccomp/bpf-fancy.c:76:3: warning: braces around scalar initializer [enabled by default]
   LABEL(&l, buf_len),
   ^
samples/seccomp/bpf-fancy.c:76:3: warning: (near initialization for ‘filter[19].k’) [enabled by default]
In file included from samples/seccomp/bpf-helper.c:17:0:
samples/seccomp/bpf-helper.h:135:2: error: #error __BITS_PER_LONG value unusable.
 #error __BITS_PER_LONG value unusable.
  ^
samples/seccomp/bpf-fancy.c:76:3: warning: excess elements in scalar initializer [enabled by default]
samples/seccomp/bpf-fancy.c:76:3: warning: (near initialization for ‘filter[19].k’) [enabled by default]
samples/seccomp/bpf-fancy.c:76:3: warning: excess elements in scalar initializer [enabled by default]
samples/seccomp/bpf-fancy.c:76:3: warning: (near initialization for ‘filter[19].k’) [enabled by default]
samples/seccomp/bpf-fancy.c:76:3: warning: excess elements in scalar initializer [enabled by default]
samples/seccomp/bpf-fancy.c:76:3: warning: (near initialization for ‘filter[19].k’) [enabled by default]
In file included from samples/seccomp/bpf-fancy.c:13:0:
./usr/include/linux/filter.h:49:27: error: expected expression before ‘{’ token
 #define BPF_STMT(code, k) { (unsigned short)(code), 0, 0, k }
                           ^
samples/seccomp/bpf-helper.h:46:2: note: in expansion of macro ‘BPF_STMT’
  BPF_STMT(BPF_RET+BPF_K, SECCOMP_RET_ALLOW)
  ^
samples/seccomp/bpf-fancy.c:78:20: note: in expansion of macro ‘ALLOW’
   JLT(sizeof(buf), ALLOW),
                    ^
samples/seccomp/bpf-fancy.c:79:3: warning: braces around scalar initializer [enabled by default]
   DENY,
   ^
samples/seccomp/bpf-fancy.c:79:3: warning: (near initialization for ‘filter[20].jf’) [enabled by default]
samples/seccomp/bpf-fancy.c:79:3: warning: excess elements in scalar initializer [enabled by default]
samples/seccomp/bpf-fancy.c:79:3: warning: (near initialization for ‘filter[20].jf’) [enabled by default]
samples/seccomp/bpf-fancy.c:79:3: warning: excess elements in scalar initializer [enabled by default]
samples/seccomp/bpf-fancy.c:79:3: warning: (near initialization for ‘filter[20].jf’) [enabled by default]
samples/seccomp/bpf-fancy.c:79:3: warning: excess elements in scalar initializer [enabled by default]
samples/seccomp/bpf-fancy.c:79:3: warning: (near initialization for ‘filter[20].jf’) [enabled by default]
samples/seccomp/bpf-fancy.c:97:2: warning: passing argument 1 of ‘syscall’ makes integer from pointer without a cast [enabled by default]
  syscall(__NR_write, STDOUT_FILENO, msg1, strlen(msg1));
  ^
In file included from samples/seccomp/bpf-fancy.c:19:0:
/usr/include/unistd.h:1061:17: note: expected ‘long int’ but argument is of type ‘struct sock_filter *’
 extern long int syscall (long int __sysno, ...) __THROW;
                 ^
samples/seccomp/bpf-fancy.c:98:2: warning: passing argument 1 of ‘syscall’ makes integer from pointer without a cast [enabled by default]
  bytes = syscall(__NR_read, STDIN_FILENO, buf, sizeof(buf)-1);
  ^
In file included from samples/seccomp/bpf-fancy.c:19:0:
/usr/include/unistd.h:1061:17: note: expected ‘long int’ but argument is of type ‘struct sock_filter *’
 extern long int syscall (long int __sysno, ...) __THROW;
                 ^
samples/seccomp/bpf-fancy.c:100:2: warning: passing argument 1 of ‘syscall’ makes integer from pointer without a cast [enabled by default]
  syscall(__NR_write, STDERR_FILENO, msg2, strlen(msg2));
  ^
In file included from samples/seccomp/bpf-fancy.c:19:0:
/usr/include/unistd.h:1061:17: note: expected ‘long int’ but argument is of type ‘struct sock_filter *’
 extern long int syscall (long int __sysno, ...) __THROW;
                 ^
samples/seccomp/bpf-fancy.c:101:2: warning: passing argument 1 of ‘syscall’ makes integer from pointer without a cast [enabled by default]
  syscall(__NR_write, STDERR_FILENO, buf, bytes);
  ^
In file included from samples/seccomp/bpf-fancy.c:19:0:
/usr/include/unistd.h:1061:17: note: expected ‘long int’ but argument is of type ‘struct sock_filter *’
 extern long int syscall (long int __sysno, ...) __THROW;
                 ^
samples/seccomp/bpf-fancy.c:103:2: warning: passing argument 1 of ‘syscall’ makes integer from pointer without a cast [enabled by default]
  syscall(__NR_write, STDERR_FILENO, msg2, strlen(msg2)+2);
  ^
In file included from samples/seccomp/bpf-fancy.c:19:0:
/usr/include/unistd.h:1061:17: note: expected ‘long int’ but argument is of type ‘struct sock_filter *’
 extern long int syscall (long int __sysno, ...) __THROW;
                 ^
make[2]: *** [samples/seccomp/bpf-helper.o] Error 1
make[2]: *** Waiting for unfinished jobs....
make[2]: *** [samples/seccomp/bpf-fancy.o] Error 1
make[1]: *** [samples/seccomp] Error 2
make: *** [samples] Error 2
make: *** Waiting for unfinished jobs....
drivers/dma/dmatest.c: In function 'dmatest_func':
drivers/dma/dmatest.c:804:1: warning: 'dmatest_func' uses dynamic stack allocation
 }
 ^
drivers/crypto/inside-secure/safexcel_cipher.c: In function 'safexcel_cipher_exit_inv':
drivers/crypto/inside-secure/safexcel_cipher.c:459:1: warning: 'safexcel_cipher_exit_inv' uses dynamic stack allocation
 }
 ^
drivers/crypto/inside-secure/safexcel_hash.c: In function 'safexcel_ahash_exit_inv':
drivers/crypto/inside-secure/safexcel_hash.c:486:1: warning: 'safexcel_ahash_exit_inv' uses dynamic stack allocation
 }
 ^
drivers/crypto/chelsio/chcr_algo.c: In function 'chcr_cipher_fallback':
drivers/crypto/chelsio/chcr_algo.c:716:1: warning: 'chcr_cipher_fallback' uses dynamic stack allocation
 }
 ^
drivers/crypto/chelsio/chcr_algo.c: In function 'chcr_ahash_setkey':
drivers/crypto/chelsio/chcr_algo.c:1904:1: warning: 'chcr_ahash_setkey' uses dynamic stack allocation
 }
 ^
drivers/crypto/chelsio/chcr_algo.c: In function 'chcr_authenc_setkey':
drivers/crypto/chelsio/chcr_algo.c:3326:1: warning: 'chcr_authenc_setkey' uses dynamic stack allocation
 }
 ^
crypto/seqiv.c: In function 'seqiv_aead_encrypt':
crypto/seqiv.c:115:1: warning: 'seqiv_aead_encrypt' uses dynamic stack allocation
 }
 ^
sound/core/pcm_native.c: In function 'constrain_params_by_rules':
sound/core/pcm_native.c:434:1: warning: 'constrain_params_by_rules' uses dynamic stack allocation
 }
 ^
crypto/echainiv.c: In function 'echainiv_encrypt':
crypto/echainiv.c:88:1: warning: 'echainiv_encrypt' uses dynamic stack allocation
 }
 ^
crypto/shash.c: In function 'crypto_shash_update':
crypto/shash.c:111:1: warning: 'crypto_shash_update' uses dynamic stack allocation
 }
 ^
crypto/shash.c: In function 'crypto_shash_final':
crypto/shash.c:146:1: warning: 'crypto_shash_final' uses dynamic stack allocation
 }
 ^
drivers/crypto/qce/ablkcipher.c: In function 'qce_ablkcipher_crypt':
drivers/crypto/qce/ablkcipher.c:229:1: warning: 'qce_ablkcipher_crypt' uses dynamic stack allocation
 }
 ^
drivers/of/unittest.c: In function 'of_unittest_printf_one':
drivers/of/unittest.c:276:1: warning: 'of_unittest_printf_one' uses dynamic stack allocation
 }
 ^
drivers/block/cryptoloop.c: In function 'cryptoloop_transfer':
drivers/block/cryptoloop.c:167:1: warning: 'cryptoloop_transfer' uses dynamic stack allocation
 }
 ^
drivers/crypto/mediatek/mtk-sha.c: In function 'mtk_sha_finish':
drivers/crypto/mediatek/mtk-sha.c:637:1: warning: 'mtk_sha_finish' uses dynamic stack allocation
 }
 ^
drivers/crypto/mediatek/mtk-sha.c: In function 'mtk_sha_setkey':
drivers/crypto/mediatek/mtk-sha.c:834:1: warning: 'mtk_sha_setkey' uses dynamic stack allocation
 }
 ^
drivers/nfc/s3fwrn5/firmware.c: In function 's3fwrn5_fw_download':
drivers/nfc/s3fwrn5/firmware.c:501:1: warning: 's3fwrn5_fw_download' uses dynamic stack allocation
 }
 ^
drivers/mmc/core/pwrseq_simple.c: In function 'mmc_pwrseq_simple_set_gpios_value.isra.9':
drivers/mmc/core/pwrseq_simple.c:52:1: warning: 'mmc_pwrseq_simple_set_gpios_value.isra.9' uses dynamic stack allocation
 }
 ^
drivers/infiniband/sw/rxe/rxe_req.c: In function 'rxe_requester':
drivers/infiniband/sw/rxe/rxe_req.c:759:1: warning: 'rxe_requester' uses dynamic stack allocation
 }
 ^
crypto/hmac.c: In function 'hmac_setkey':
crypto/hmac.c:88:1: warning: 'hmac_setkey' uses dynamic stack allocation
 }
 ^
drivers/block/drbd/drbd_receiver.c: In function 'drbd_do_auth':
drivers/block/drbd/drbd_receiver.c:5397:1: warning: 'drbd_do_auth' uses dynamic stack allocation
 }
 ^
drivers/block/drbd/drbd_worker.c: In function 'drbd_csum_ee':
drivers/block/drbd/drbd_worker.c:325:1: warning: 'drbd_csum_ee' uses dynamic stack allocation
 }
 ^
drivers/block/drbd/drbd_worker.c: In function 'drbd_csum_bio':
drivers/block/drbd/drbd_worker.c:352:1: warning: 'drbd_csum_bio' uses dynamic stack allocation
 }
 ^
drivers/misc/tifm_7xx1.c: In function 'tifm_7xx1_resume':
drivers/misc/tifm_7xx1.c:298:1: warning: 'tifm_7xx1_resume' uses dynamic stack allocation
 }
 ^
drivers/infiniband/sw/rxe/rxe_recv.c: In function 'rxe_rcv':
drivers/infiniband/sw/rxe/rxe_recv.c:421:1: warning: 'rxe_rcv' uses dynamic stack allocation
 }
 ^
crypto/xcbc.c: In function 'crypto_xcbc_digest_setkey':
crypto/xcbc.c:80:1: warning: 'crypto_xcbc_digest_setkey' uses dynamic stack allocation
 }
 ^
drivers/crypto/s5p-sss.c: In function 's5p_hash_final':
drivers/crypto/s5p-sss.c:1589:1: warning: 's5p_hash_final' uses dynamic stack allocation
 }
 ^
drivers/net/ppp/ppp_mppe.c: In function 'get_new_key_from_sha':
drivers/net/ppp/ppp_mppe.c:158:1: warning: 'get_new_key_from_sha' uses dynamic stack allocation
 }
 ^
drivers/net/ppp/ppp_mppe.c: In function 'mppe_rekey':
drivers/net/ppp/ppp_mppe.c:195:1: warning: 'mppe_rekey' uses dynamic stack allocation
 }
 ^
drivers/net/ppp/ppp_mppe.c: In function 'mppe_decompress':
drivers/net/ppp/ppp_mppe.c:666:1: warning: 'mppe_decompress' uses dynamic stack allocation
 }
 ^
drivers/net/ppp/ppp_mppe.c: In function 'mppe_compress':
drivers/net/ppp/ppp_mppe.c:441:1: warning: 'mppe_compress' uses dynamic stack allocation
 }
 ^
drivers/input/joystick/analog.c:176:2: warning: #warning Precise timer not defined for this architecture. [-Wcpp]
 #warning Precise timer not defined for this architecture.
  ^
drivers/gpu/drm/i2c/tda998x_drv.c: In function 'reg_write_range':
drivers/gpu/drm/i2c/tda998x_drv.c:489:1: warning: 'reg_write_range' uses dynamic stack allocation
 }
 ^
drivers/net/phy/mdio-mux-gpio.c: In function 'mdio_mux_gpio_switch_fn':
drivers/net/phy/mdio-mux-gpio.c:42:1: warning: 'mdio_mux_gpio_switch_fn' uses dynamic stack allocation
 }
 ^
drivers/iio/humidity/hts221_i2c.c: In function 'hts221_i2c_write':
drivers/iio/humidity/hts221_i2c.c:59:1: warning: 'hts221_i2c_write' uses dynamic stack allocation
 }
 ^
drivers/md/dm-stripe.c: In function 'stripe_status':
drivers/md/dm-stripe.c:395:1: warning: 'stripe_status' uses dynamic stack allocation
 }
 ^
drivers/infiniband/sw/rxe/rxe_mr.c: In function 'rxe_mem_copy':
drivers/infiniband/sw/rxe/rxe_mr.c:431:1: warning: 'rxe_mem_copy' uses dynamic stack allocation
 }
 ^
drivers/md/dm-bufio.c: In function 'dm_bufio_client_create':
drivers/md/dm-bufio.c:1756:2: warning: ignoring return value of 'register_shrinker', declared with attribute warn_unused_result [-Wunused-result]
  register_shrinker(&c->shrinker);
  ^
drivers/infiniband/sw/rxe/rxe_icrc.c: In function 'rxe_icrc_hdr':
drivers/infiniband/sw/rxe/rxe_icrc.c:96:1: warning: 'rxe_icrc_hdr' uses dynamic stack allocation
 }
 ^
net/ceph/crypto.c: In function 'ceph_crypt':
net/ceph/crypto.c:293:1: warning: 'ceph_crypt' uses dynamic stack allocation
 }
 ^
drivers/gpio/gpio-max3191x.c: In function 'max3191x_probe':
drivers/gpio/gpio-max3191x.c:437:1: warning: 'max3191x_probe' uses dynamic stack allocation
 }
 ^
drivers/md/dm-crypt.c: In function 'crypt_iv_essiv_init':
drivers/md/dm-crypt.c:345:1: warning: 'crypt_iv_essiv_init' uses dynamic stack allocation
 }
 ^
drivers/md/dm-crypt.c: In function 'crypt_iv_tcw_whitening.isra.28':
drivers/md/dm-crypt.c:787:1: warning: 'crypt_iv_tcw_whitening.isra.28' uses dynamic stack allocation
 }
 ^
drivers/md/dm-crypt.c: In function 'crypt_iv_lmk_one.isra.29':
drivers/md/dm-crypt.c:640:1: warning: 'crypt_iv_lmk_one.isra.29' uses dynamic stack allocation
 }
 ^
drivers/mtd/nftlmount.c: In function 'check_free_sectors.isra.2':
drivers/mtd/nftlmount.c:298:1: warning: 'check_free_sectors.isra.2' uses dynamic stack allocation
 }
 ^
drivers/mtd/inftlmount.c: In function 'INFTL_formatblock':
drivers/mtd/inftlmount.c:428:1: warning: 'INFTL_formatblock' uses dynamic stack allocation
 }
 ^
net/bridge/netfilter/ebtables.c: In function 'compat_copy_everything_to_user':
net/bridge/netfilter/ebtables.c:1884:1: warning: 'compat_copy_everything_to_user' uses dynamic stack allocation
 }
 ^
drivers/input/keyboard/stmpe-keypad.c: In function 'stmpe_keypad_irq':
drivers/input/keyboard/stmpe-keypad.c:184:1: warning: 'stmpe_keypad_irq' uses dynamic stack allocation
 }
 ^
crypto/cbc.c: In function 'crypto_cbc_decrypt':
crypto/cbc.c:79:1: warning: 'crypto_cbc_decrypt' uses dynamic stack allocation
 }
 ^
drivers/net/ethernet/chelsio/cxgb3/t3_hw.c: In function 'vpdstrtou16.constprop':
drivers/net/ethernet/chelsio/cxgb3/t3_hw.c:700:1: warning: 'vpdstrtou16.constprop' uses dynamic stack allocation
 }
 ^
drivers/net/ethernet/chelsio/cxgb3/t3_hw.c: In function 'vpdstrtouint.constprop':
drivers/net/ethernet/chelsio/cxgb3/t3_hw.c:691:1: warning: 'vpdstrtouint.constprop' uses dynamic stack allocation
 }
 ^
drivers/iio/potentiometer/ds1803.c: In function 'ds1803_read_raw':
drivers/iio/potentiometer/ds1803.c:86:1: warning: 'ds1803_read_raw' uses dynamic stack allocation
 }
 ^
drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c: In function 'st_lsm6dsx_read_fifo':
drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c:306:1: warning: 'st_lsm6dsx_read_fifo' uses dynamic stack allocation
 }
 ^
kernel/events/ring_buffer.c: In function 'perf_output_begin_forward':
kernel/events/ring_buffer.c:237:1: warning: 'perf_output_begin_forward' uses dynamic stack allocation
 }
 ^
kernel/events/ring_buffer.c: In function 'perf_output_begin_backward':
kernel/events/ring_buffer.c:243:1: warning: 'perf_output_begin_backward' uses dynamic stack allocation
 }
 ^
kernel/events/ring_buffer.c: In function 'perf_output_begin':
kernel/events/ring_buffer.c:251:1: warning: 'perf_output_begin' uses dynamic stack allocation
 }
 ^
kernel/events/core.c: In function 'perf_log_throttle':
kernel/events/core.c:7266:1: warning: 'perf_log_throttle' uses dynamic stack allocation
 }
 ^
kernel/events/core.c: In function 'perf_log_itrace_start':
kernel/events/core.c:7307:1: warning: 'perf_log_itrace_start' uses dynamic stack allocation
 }
 ^
kernel/events/core.c: In function 'perf_event_switch_output':
kernel/events/core.c:7199:1: warning: 'perf_event_switch_output' uses dynamic stack allocation
 }
 ^
kernel/events/core.c: In function 'perf_event_task_output':
kernel/events/core.c:6483:1: warning: 'perf_event_task_output' uses dynamic stack allocation
 }
 ^
kernel/events/core.c: In function 'perf_event_namespaces_output':
kernel/events/core.c:6676:1: warning: 'perf_event_namespaces_output' uses dynamic stack allocation
 }
 ^
drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c: In function 'st_lsm6dsx_i2c_write':
drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c:53:1: warning: 'st_lsm6dsx_i2c_write' uses dynamic stack allocation
 }
 ^
kernel/events/core.c: In function 'perf_event_read_event':
kernel/events/core.c:6204:1: warning: 'perf_event_read_event' uses dynamic stack allocation
 }
 ^
kernel/events/core.c: In function 'perf_event_comm_output':
kernel/events/core.c:6577:1: warning: 'perf_event_comm_output' uses dynamic stack allocation
 }
 ^
kernel/events/core.c: In function 'perf_event_mmap_output':
kernel/events/core.c:6839:1: warning: 'perf_event_mmap_output' uses dynamic stack allocation
 }
 ^
kernel/events/core.c: In function 'perf_swevent_hrtimer':
kernel/events/core.c:8607:1: warning: 'perf_swevent_hrtimer' uses dynamic stack allocation
 }
 ^
kernel/events/core.c: In function 'perf_event_aux_event':
kernel/events/core.c:7107:1: warning: 'perf_event_aux_event' uses dynamic stack allocation
 }
 ^
kernel/events/core.c: In function 'perf_log_lost_samples':
kernel/events/core.c:7140:1: warning: 'perf_log_lost_samples' uses dynamic stack allocation
 }
 ^
kernel/events/core.c: In function 'perf_tp_event':
kernel/events/core.c:7944:1: warning: 'perf_tp_event' uses dynamic stack allocation
 }
 ^
kernel/events/core.c: In function '___perf_sw_event':
kernel/events/core.c:7632:1: warning: '___perf_sw_event' uses dynamic stack allocation
 }
 ^
crypto/pcbc.c: In function 'crypto_pcbc_decrypt':
crypto/pcbc.c:185:1: warning: 'crypto_pcbc_decrypt' uses dynamic stack allocation
 }
 ^
crypto/cts.c: In function 'cts_cbc_encrypt':
crypto/cts.c:129:1: warning: 'cts_cbc_encrypt' uses dynamic stack allocation
 }
 ^
crypto/pcbc.c: In function 'crypto_pcbc_encrypt':
crypto/pcbc.c:113:1: warning: 'crypto_pcbc_encrypt' uses dynamic stack allocation
 }
 ^
crypto/cts.c: In function 'cts_cbc_decrypt':
crypto/cts.c:221:1: warning: 'cts_cbc_decrypt' uses dynamic stack allocation
 }
 ^
net/core/rtnetlink.c: In function 'rtnl_newlink':
net/core/rtnetlink.c:2864:1: warning: 'rtnl_newlink' uses dynamic stack allocation
 }
 ^
mm/slub.c: In function 'unfreeze_partials.isra.48':
mm/slub.c:2221:1: warning: 'unfreeze_partials.isra.48' uses dynamic stack allocation
 }
 ^
mm/slub.c: In function 'get_partial_node.isra.49':
mm/slub.c:1853:1: warning: 'get_partial_node.isra.49' uses dynamic stack allocation
 }
 ^
mm/slub.c: In function 'deactivate_slab.isra.50':
mm/slub.c:2153:1: warning: 'deactivate_slab.isra.50' uses dynamic stack allocation
 }
 ^
mm/slub.c: In function '___slab_alloc':
mm/slub.c:2606:1: warning: '___slab_alloc' uses dynamic stack allocation
 }
 ^
crypto/ctr.c: In function 'crypto_ctr_crypt':
crypto/ctr.c:155:1: warning: 'crypto_ctr_crypt' uses dynamic stack allocation
 }
 ^
mm/slub.c: In function '__slab_free':
mm/slub.c:2907:1: warning: '__slab_free' uses dynamic stack allocation
 }
 ^
drivers/net/ethernet/marvell/mvpp2.c: In function 'mvpp2_swf_bm_pool_init':
drivers/net/ethernet/marvell/mvpp2.c:548:2: warning: overflow in implicit constant conversion [-Woverflow]
  ((total_size) - NET_SKB_PAD - MVPP2_SKB_SHINFO_SIZE)
  ^
drivers/net/ethernet/marvell/mvpp2.c:788:34: note: in expansion of macro 'MVPP2_RX_MAX_PKT_SIZE'
 #define MVPP2_BM_SHORT_PKT_SIZE  MVPP2_RX_MAX_PKT_SIZE(512)
                                  ^
drivers/net/ethernet/marvell/mvpp2.c:4277:8: note: in expansion of macro 'MVPP2_BM_SHORT_PKT_SIZE'
        MVPP2_BM_SHORT_PKT_SIZE);
        ^
drivers/net/wan/lmc/lmc_main.c: In function 'lmc_softreset':
drivers/net/wan/lmc/lmc_main.c:1854:37: warning: passing argument 1 of 'virt_to_bus' discards 'volatile' qualifier from pointer target type
         sc->lmc_rxring[i].buffer2 = virt_to_bus (&sc->lmc_rxring[i + 1]);
                                     ^
In file included from ./arch/s390/include/asm/io.h:79:0,
                 from ./include/linux/io.h:25,
                 from ./include/linux/pci.h:33,
                 from drivers/net/wan/lmc/lmc_main.c:49:
./include/asm-generic/io.h:946:29: note: expected 'void *' but argument is of type 'volatile struct tulip_desc_t *'
 static inline unsigned long virt_to_bus(void *address)
                             ^
drivers/net/wan/lmc/lmc_main.c:1863:41: warning: passing argument 1 of 'virt_to_bus' discards 'volatile' qualifier from pointer target type
         sc->lmc_rxring[i - 1].buffer2 = virt_to_bus(&sc->lmc_rxring[0]); /* Point back to the start */
                                         ^
In file included from ./arch/s390/include/asm/io.h:79:0,
                 from ./include/linux/io.h:25,
                 from ./include/linux/pci.h:33,
                 from drivers/net/wan/lmc/lmc_main.c:49:
./include/asm-generic/io.h:946:29: note: expected 'void *' but argument is of type 'volatile struct tulip_desc_t *'
 static inline unsigned long virt_to_bus(void *address)
                             ^
In file included from drivers/net/wan/lmc/lmc.h:5:0,
                 from drivers/net/wan/lmc/lmc_main.c:71:
drivers/net/wan/lmc/lmc_main.c:1865:36: warning: passing argument 1 of 'virt_to_bus' discards 'volatile' qualifier from pointer target type
     LMC_CSR_WRITE (sc, csr_rxlist, virt_to_bus (sc->lmc_rxring)); /* write base address */
                                    ^
drivers/net/wan/lmc/lmc_var.h:47:8: note: in definition of macro 'LMC_CSR_WRITE'
  outl((val), (sc)->lmc_csrs.reg)
        ^
In file included from ./arch/s390/include/asm/io.h:79:0,
                 from ./include/linux/io.h:25,
                 from ./include/linux/pci.h:33,
                 from drivers/net/wan/lmc/lmc_main.c:49:
./include/asm-generic/io.h:946:29: note: expected 'void *' but argument is of type 'volatile struct tulip_desc_t *'
 static inline unsigned long virt_to_bus(void *address)
                             ^
drivers/net/wan/lmc/lmc_main.c:1876:37: warning: passing argument 1 of 'virt_to_bus' discards 'volatile' qualifier from pointer target type
         sc->lmc_txring[i].buffer2 = virt_to_bus (&sc->lmc_txring[i + 1]);
                                     ^
In file included from ./arch/s390/include/asm/io.h:79:0,
                 from ./include/linux/io.h:25,
                 from ./include/linux/pci.h:33,
                 from drivers/net/wan/lmc/lmc_main.c:49:
./include/asm-generic/io.h:946:29: note: expected 'void *' but argument is of type 'volatile struct tulip_desc_t *'
 static inline unsigned long virt_to_bus(void *address)
                             ^
drivers/net/wan/lmc/lmc_main.c:1878:37: warning: passing argument 1 of 'virt_to_bus' discards 'volatile' qualifier from pointer target type
     sc->lmc_txring[i - 1].buffer2 = virt_to_bus (&sc->lmc_txring[0]);
                                     ^
In file included from ./arch/s390/include/asm/io.h:79:0,
                 from ./include/linux/io.h:25,
                 from ./include/linux/pci.h:33,
                 from drivers/net/wan/lmc/lmc_main.c:49:
./include/asm-generic/io.h:946:29: note: expected 'void *' but argument is of type 'volatile struct tulip_desc_t *'
 static inline unsigned long virt_to_bus(void *address)
                             ^
In file included from drivers/net/wan/lmc/lmc.h:5:0,
                 from drivers/net/wan/lmc/lmc_main.c:71:
drivers/net/wan/lmc/lmc_main.c:1879:36: warning: passing argument 1 of 'virt_to_bus' discards 'volatile' qualifier from pointer target type
     LMC_CSR_WRITE (sc, csr_txlist, virt_to_bus (sc->lmc_txring));
                                    ^
drivers/net/wan/lmc/lmc_var.h:47:8: note: in definition of macro 'LMC_CSR_WRITE'
  outl((val), (sc)->lmc_csrs.reg)
        ^
In file included from ./arch/s390/include/asm/io.h:79:0,
                 from ./include/linux/io.h:25,
                 from ./include/linux/pci.h:33,
                 from drivers/net/wan/lmc/lmc_main.c:49:
./include/asm-generic/io.h:946:29: note: expected 'void *' but argument is of type 'volatile struct tulip_desc_t *'
 static inline unsigned long virt_to_bus(void *address)
                             ^
lib/btree.c: In function 'btree_get_prev':
lib/btree.c:360:1: warning: 'btree_get_prev' uses dynamic stack allocation
 }
 ^
lib/btree.c: In function 'btree_merge':
lib/btree.c:673:1: warning: 'btree_merge' uses dynamic stack allocation
 }
 ^
crypto/ccm.c: In function 'crypto_ccm_auth':
crypto/ccm.c:235:1: warning: 'crypto_ccm_auth' uses dynamic stack allocation
 }
 ^
net/mac802154/llsec.c: In function 'llsec_do_encrypt':
net/mac802154/llsec.c:707:1: warning: 'llsec_do_encrypt' uses dynamic stack allocation
 }
 ^
net/mac802154/llsec.c: In function 'llsec_do_decrypt.isra.7':
net/mac802154/llsec.c:912:1: warning: 'llsec_do_decrypt.isra.7' uses dynamic stack allocation
 }
 ^
crypto/gcm.c: In function 'crypto_rfc4543_crypt':
crypto/gcm.c:1061:1: warning: 'crypto_rfc4543_crypt' uses dynamic stack allocation
 }
 ^
drivers/gpio/gpio-stmpe.c: In function 'stmpe_gpio_irq':
drivers/gpio/gpio-stmpe.c:422:1: warning: 'stmpe_gpio_irq' uses dynamic stack allocation
 }
 ^
drivers/staging/android/ashmem.c: In function 'ashmem_init':
drivers/staging/android/ashmem.c:867:2: warning: ignoring return value of 'register_shrinker', declared with attribute warn_unused_result [-Wunused-result]
  register_shrinker(&ashmem_shrinker);
  ^
net/llc/llc_sap.c: In function 'llc_sap_handler':
net/llc/llc_sap.c:442:1: warning: 'llc_sap_handler' uses dynamic stack allocation
 }
 ^
drivers/input/touchscreen/cyttsp4_core.c: In function 'cyttsp4_irq':
drivers/input/touchscreen/cyttsp4_core.c:1243:1: warning: 'cyttsp4_irq' uses dynamic stack allocation
 }
 ^
drivers/md/dm-raid1.c: In function 'mirror_status':
drivers/md/dm-raid1.c:1446:1: warning: 'mirror_status' uses dynamic stack allocation
 }
 ^
drivers/md/dm-raid1.c: In function 'mirror_flush':
drivers/md/dm-raid1.c:285:1: warning: 'mirror_flush' uses dynamic stack allocation
 }
 ^
drivers/md/dm-raid1.c: In function 'do_writes':
drivers/md/dm-raid1.c:790:1: warning: 'do_writes' uses dynamic stack allocation
 }
 ^
net/netfilter/nfnetlink.c: In function 'nfnetlink_rcv_msg':
net/netfilter/nfnetlink.c:225:1: warning: 'nfnetlink_rcv_msg' uses dynamic stack allocation
 }
 ^
net/netfilter/nfnetlink.c: In function 'nfnetlink_rcv':
net/netfilter/nfnetlink.c:516:1: warning: 'nfnetlink_rcv' uses dynamic stack allocation
 }
 ^
drivers/staging/ccree/ssi_cipher.c: In function 'ssi_blkcipher_setkey':
drivers/staging/ccree/ssi_cipher.c:419:1: warning: 'ssi_blkcipher_setkey' uses dynamic stack allocation
 }
 ^
drivers/staging/android/ion/ion_heap.c: In function 'ion_heap_init_shrinker':
drivers/staging/android/ion/ion_heap.c:315:2: warning: ignoring return value of 'register_shrinker', declared with attribute warn_unused_result [-Wunused-result]
  register_shrinker(&heap->shrinker);
  ^
crypto/cryptd.c: In function 'cryptd_skcipher_decrypt':
crypto/cryptd.c:530:1: warning: 'cryptd_skcipher_decrypt' uses dynamic stack allocation
 }
 ^
crypto/cryptd.c: In function 'cryptd_skcipher_encrypt':
crypto/cryptd.c:502:1: warning: 'cryptd_skcipher_encrypt' uses dynamic stack allocation
 }
 ^
arch/s390/kernel/perf_cpum_sf.c: In function 'perf_push_sample':
arch/s390/kernel/perf_cpum_sf.c:1071:1: warning: 'perf_push_sample' uses dynamic stack allocation
 }
 ^
net/core/pktgen.c: In function 'pktgen_if_write':
net/core/pktgen.c:1799:1: warning: 'pktgen_if_write' uses dynamic stack allocation
 }
 ^
lib/libcrc32c.c: In function 'crc32c':
lib/libcrc32c.c:59:1: warning: 'crc32c' uses dynamic stack allocation
 }
 ^
kernel/trace/ftrace.c: In function 'ftrace_mod_callback':
kernel/trace/ftrace.c:4092:1: warning: 'ftrace_mod_callback' uses dynamic stack allocation
 }
 ^
drivers/gpu/drm/ttm/ttm_page_alloc.c: In function 'ttm_pool_mm_shrink_init':
drivers/gpu/drm/ttm/ttm_page_alloc.c:485:2: warning: ignoring return value of 'register_shrinker', declared with attribute warn_unused_result [-Wunused-result]
  register_shrinker(&manager->mm_shrink);
  ^
drivers/md/dm-verity-fec.c: In function 'fec_decode_rsb':
drivers/md/dm-verity-fec.c:403:1: warning: 'fec_decode_rsb' uses dynamic stack allocation
 }
 ^
drivers/power/supply/da9150-fg.c: In function 'da9150_fg_read_attr.isra.4':
drivers/power/supply/da9150-fg.c:108:1: warning: 'da9150_fg_read_attr.isra.4' uses dynamic stack allocation
 }
 ^
net/openvswitch/actions.c: In function 'ovs_fragment':
net/openvswitch/actions.c:943:1: warning: 'ovs_fragment' uses dynamic stack allocation
 }
 ^
kernel/smp.c: In function 'smp_call_function_single':
kernel/smp.c:307:1: warning: 'smp_call_function_single' uses dynamic stack allocation
 }
 ^
drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c: In function 'vchiq_dump_service_use_state':
drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c:3153:1: warning: 'vchiq_dump_service_use_state' uses dynamic stack allocation
 }
 ^
net/ipv6/xfrm6_state.c: In function '__xfrm6_sort':
net/ipv6/xfrm6_state.c:84:1: warning: '__xfrm6_sort' uses dynamic stack allocation
 }
 ^
drivers/net/ethernet/neterion/vxge/vxge-config.c: In function 'vxge_hw_device_hw_info_get':
drivers/net/ethernet/neterion/vxge/vxge-config.c:1089:1: warning: 'vxge_hw_device_hw_info_get' uses dynamic stack allocation
 }
 ^
fs/crypto/keyinfo.c: In function 'fscrypt_get_encryption_info':
fs/crypto/keyinfo.c:354:1: warning: 'fscrypt_get_encryption_info' uses dynamic stack allocation
 }
 ^
fs/ecryptfs/crypto.c: In function 'ecryptfs_hash_digest':
fs/ecryptfs/crypto.c:75:1: warning: 'ecryptfs_hash_digest' uses dynamic stack allocation
 }
 ^
net/netfilter/nfnetlink_cttimeout.c: In function 'ctnl_timeout_parse_policy':
net/netfilter/nfnetlink_cttimeout.c:68:1: warning: 'ctnl_timeout_parse_policy' uses dynamic stack allocation
 }
 ^
lib/reed_solomon/reed_solomon.c: In function 'decode_rs8':
lib/reed_solomon/reed_solomon.c:329:1: warning: 'decode_rs8' uses dynamic stack allocation
 }
 ^
lib/reed_solomon/reed_solomon.c: In function 'decode_rs16':
lib/reed_solomon/reed_solomon.c:373:1: warning: 'decode_rs16' uses dynamic stack allocation
 }
 ^
net/netfilter/nfnetlink_cthelper.c: In function 'nfnl_cthelper_update_policy_all.isra.9':
net/netfilter/nfnetlink_cthelper.c:344:1: warning: 'nfnl_cthelper_update_policy_all.isra.9' uses dynamic stack allocation
 }
 ^
net/ipv6/proc.c: In function 'snmp6_seq_show_item':
net/ipv6/proc.c:214:1: warning: 'snmp6_seq_show_item' uses dynamic stack allocation
 }
 ^
net/ipv6/proc.c: In function 'snmp6_seq_show_item64.isra.1.constprop':
net/ipv6/proc.c:227:1: warning: 'snmp6_seq_show_item64.isra.1.constprop' uses dynamic stack allocation
 }
 ^
drivers/md/dm-integrity.c: In function 'integrity_sector_checksum':
drivers/md/dm-integrity.c:1231:1: warning: 'integrity_sector_checksum' uses dynamic stack allocation
 }
 ^
drivers/md/dm-integrity.c: In function 'rw_section_mac':
drivers/md/dm-integrity.c:558:1: warning: 'rw_section_mac' uses dynamic stack allocation
 }
 ^
drivers/md/dm-integrity.c: In function 'do_journal_write':
drivers/md/dm-integrity.c:1974:1: warning: 'do_journal_write' uses dynamic stack allocation
 }
 ^
drivers/md/dm-integrity.c: In function 'integrity_metadata':
drivers/md/dm-integrity.c:1335:1: warning: 'integrity_metadata' uses dynamic stack allocation
 }
 ^
drivers/md/dm-integrity.c: In function '__journal_read_write':
drivers/md/dm-integrity.c:1568:1: warning: '__journal_read_write' uses dynamic stack allocation
 }
 ^
net/rds/connection.c: In function 'rds_for_each_conn_info':
net/rds/connection.c:565:1: warning: 'rds_for_each_conn_info' uses dynamic stack allocation
 }
 ^
net/rds/connection.c: In function 'rds_conn_info':
net/rds/connection.c:646:1: warning: 'rds_conn_info' uses dynamic stack allocation
 }
 ^
crypto/authenc.c: In function 'crypto_authenc_encrypt':
crypto/authenc.c:233:1: warning: 'crypto_authenc_encrypt' uses dynamic stack allocation
 }
 ^
crypto/authencesn.c: In function 'crypto_authenc_esn_copy':
crypto/authencesn.c:193:1: warning: 'crypto_authenc_esn_copy' uses dynamic stack allocation
 }
 ^
drivers/target/iscsi/iscsi_target.c: In function 'iscsit_send_datain':
drivers/target/iscsi/iscsi_target.c:2852:1: warning: 'iscsit_send_datain' uses dynamic stack allocation
 }
 ^
lib/bch.c: In function 'init_bch':
lib/bch.c:1336:1: warning: 'init_bch' uses dynamic stack allocation
 }
 ^
lib/bch.c: In function 'find_affine4_roots':
lib/bch.c:540:1: warning: 'find_affine4_roots' uses dynamic stack allocation
 }
 ^
net/ipv4/proc.c: In function 'snmp_seq_show':
net/ipv4/proc.c:462:1: warning: 'snmp_seq_show' uses dynamic stack allocation
 }
 ^
drivers/usb/wusbcore/crypto.c: In function 'wusb_ccm_mac':
drivers/usb/wusbcore/crypto.c:282:1: warning: 'wusb_ccm_mac' uses dynamic stack allocation
 }
 ^
drivers/usb/misc/usbtest.c: In function 'test_queue':
drivers/usb/misc/usbtest.c:2067:1: warning: 'test_queue' uses dynamic stack allocation
 }
 ^
drivers/scsi/device_handler/scsi_dh_emc.c: In function 'send_trespass_cmd':
drivers/scsi/device_handler/scsi_dh_emc.c:294:1: warning: 'send_trespass_cmd' uses dynamic stack allocation
 }
 ^
drivers/scsi/device_handler/scsi_dh_rdac.c: In function 'send_mode_select':
drivers/scsi/device_handler/scsi_dh_rdac.c:581:1: warning: 'send_mode_select' uses dynamic stack allocation
 }
 ^
net/sctp/sm_make_chunk.c: In function 'sctp_pack_cookie.isra.8':
net/sctp/sm_make_chunk.c:1687:1: warning: 'sctp_pack_cookie.isra.8' uses dynamic stack allocation
 }
 ^
net/sctp/sm_make_chunk.c: In function 'sctp_unpack_cookie':
net/sctp/sm_make_chunk.c:1866:1: warning: 'sctp_unpack_cookie' uses dynamic stack allocation
 }
 ^
drivers/scsi/device_handler/scsi_dh_alua.c: In function 'alua_rtpg':
drivers/scsi/device_handler/scsi_dh_alua.c:715:1: warning: 'alua_rtpg' uses dynamic stack allocation
 }
 ^
drivers/scsi/device_handler/scsi_dh_alua.c: In function 'alua_rtpg_work':
drivers/scsi/device_handler/scsi_dh_alua.c:856:1: warning: 'alua_rtpg_work' uses dynamic stack allocation
 }
 ^
net/rxrpc/rxkad.c: In function 'rxkad_prime_packet_security':
net/rxrpc/rxkad.c:141:1: warning: 'rxkad_prime_packet_security' uses dynamic stack allocation
 }
 ^
net/rxrpc/rxkad.c: In function 'rxkad_verify_packet_1':
net/rxrpc/rxkad.c:398:1: warning: 'rxkad_verify_packet_1' uses dynamic stack allocation
 }
 ^
drivers/target/iscsi/cxgbit/cxgbit_target.c: In function 'cxgbit_tx_datain_iso.isra.31':
drivers/target/iscsi/cxgbit/cxgbit_target.c:501:1: warning: 'cxgbit_tx_datain_iso.isra.31' uses dynamic stack allocation
 }
 ^
net/rxrpc/rxkad.c: In function 'rxkad_verify_packet_2':
net/rxrpc/rxkad.c:498:1: warning: 'rxkad_verify_packet_2' uses dynamic stack allocation
 }
 ^
net/rxrpc/rxkad.c: In function 'rxkad_verify_packet':
net/rxrpc/rxkad.c:563:1: warning: 'rxkad_verify_packet' uses dynamic stack allocation
 }
 ^
fs/f2fs/checkpoint.c: In function 'get_checkpoint_version':
fs/f2fs/checkpoint.c:749:1: warning: 'get_checkpoint_version' uses dynamic stack allocation
 }
 ^
net/rxrpc/rxkad.c: In function 'rxkad_decrypt_response.isra.5':
net/rxrpc/rxkad.c:1042:1: warning: 'rxkad_decrypt_response.isra.5' uses dynamic stack allocation
 }
 ^
net/rxrpc/rxkad.c: In function 'rxkad_encrypt_response.isra.6':
net/rxrpc/rxkad.c:765:1: warning: 'rxkad_encrypt_response.isra.6' uses dynamic stack allocation
 }
 ^
net/rxrpc/rxkad.c: In function 'rxkad_secure_packet_encrypt.isra.8':
net/rxrpc/rxkad.c:242:1: warning: 'rxkad_secure_packet_encrypt.isra.8' uses dynamic stack allocation
 }
 ^
net/rxrpc/rxkad.c: In function 'rxkad_secure_packet':
net/rxrpc/rxkad.c:312:1: warning: 'rxkad_secure_packet' uses dynamic stack allocation
 }
 ^
fs/f2fs/checkpoint.c: In function 'do_checkpoint':
fs/f2fs/checkpoint.c:1342:1: warning: 'do_checkpoint' uses dynamic stack allocation
 }
 ^
fs/btrfs/raid56.c: In function 'finish_parity_scrub':
fs/btrfs/raid56.c:2477:1: warning: 'finish_parity_scrub' uses dynamic stack allocation
 }
 ^
fs/btrfs/raid56.c: In function 'finish_rmw':
fs/btrfs/raid56.c:1332:1: warning: 'finish_rmw' uses dynamic stack allocation
 }
 ^
net/sunrpc/auth_gss/gss_krb5_crypto.c: In function 'gss_krb5_cts_crypt':
net/sunrpc/auth_gss/gss_krb5_crypto.c:727:1: warning: 'gss_krb5_cts_crypt' uses dynamic stack allocation
 }
 ^
net/sunrpc/auth_gss/gss_krb5_crypto.c: In function 'krb5_encrypt':
net/sunrpc/auth_gss/gss_krb5_crypto.c:91:1: warning: 'krb5_encrypt' uses dynamic stack allocation
 }
 ^
net/sunrpc/auth_gss/gss_krb5_crypto.c: In function 'krb5_decrypt':
net/sunrpc/auth_gss/gss_krb5_crypto.c:129:1: warning: 'krb5_decrypt' uses dynamic stack allocation
 }
 ^
net/sunrpc/auth_gss/gss_krb5_crypto.c: In function 'gss_encrypt_xdr_buf':
net/sunrpc/auth_gss/gss_krb5_crypto.c:554:1: warning: 'gss_encrypt_xdr_buf' uses dynamic stack allocation
 }
 ^
net/sunrpc/auth_gss/gss_krb5_crypto.c: In function 'gss_decrypt_xdr_buf':
net/sunrpc/auth_gss/gss_krb5_crypto.c:633:1: warning: 'gss_decrypt_xdr_buf' uses dynamic stack allocation
 }
 ^
net/sunrpc/auth_gss/gss_krb5_crypto.c: In function 'gss_krb5_aes_encrypt':
net/sunrpc/auth_gss/gss_krb5_crypto.c:848:1: warning: 'gss_krb5_aes_encrypt' uses dynamic stack allocation
 }
 ^
net/sunrpc/auth_gss/gss_krb5_crypto.c: In function 'gss_krb5_aes_decrypt':
net/sunrpc/auth_gss/gss_krb5_crypto.c:941:1: warning: 'gss_krb5_aes_decrypt' uses dynamic stack allocation
 }
 ^
net/sctp/auth.c: In function 'sctp_auth_calculate_hmac':
net/sctp/auth.c:762:1: warning: 'sctp_auth_calculate_hmac' uses dynamic stack allocation
 }
 ^
fs/btrfs/hash.c: In function 'btrfs_crc32c':
fs/btrfs/hash.c:54:1: warning: 'btrfs_crc32c' uses dynamic stack allocation
 }
 ^
drivers/scsi/osd/osd_initiator.c: In function 'osd_req_decode_sense_full':
drivers/scsi/osd/osd_initiator.c:1955:1: warning: 'osd_req_decode_sense_full' uses dynamic stack allocation
 }
 ^
net/netfilter/nf_tables_api.c: In function 'nft_obj_init':
net/netfilter/nf_tables_api.c:4438:1: warning: 'nft_obj_init' uses dynamic stack allocation
 }
 ^
crypto/algif_hash.c: In function 'hash_accept':
crypto/algif_hash.c:281:1: warning: 'hash_accept' uses dynamic stack allocation
 }
 ^
fs/isofs/compress.c: In function 'zisofs_fill_pages':
fs/isofs/compress.c:291:1: warning: 'zisofs_fill_pages' uses dynamic stack allocation
 }
 ^
fs/isofs/compress.c: In function 'zisofs_readpage':
fs/isofs/compress.c:361:1: warning: 'zisofs_readpage' uses dynamic stack allocation
 }
 ^
crypto/ecc.c: In function 'vli_mmod_fast':
crypto/ecc.c:533:1: warning: 'vli_mmod_fast' uses dynamic stack allocation
 }
 ^
crypto/ecc.c: In function 'vli_mod_square_fast':
crypto/ecc.c:553:1: warning: 'vli_mod_square_fast' uses dynamic stack allocation
 }
 ^
crypto/ecc.c: In function 'vli_mod_mult_fast':
crypto/ecc.c:543:1: warning: 'vli_mod_mult_fast' uses dynamic stack allocation
 }
 ^
crypto/ecc.c: In function 'xycz_add_c':
crypto/ecc.c:841:1: warning: 'xycz_add_c' uses dynamic stack allocation
 }
 ^
crypto/ecc.c: In function 'xycz_add':
crypto/ecc.c:784:1: warning: 'xycz_add' uses dynamic stack allocation
 }
 ^
crypto/ecc.c: In function 'apply_z':
crypto/ecc.c:720:1: warning: 'apply_z' uses dynamic stack allocation
 }
 ^
crypto/ecc.c: In function 'ecc_point_mult.isra.0':
crypto/ecc.c:896:1: warning: 'ecc_point_mult.isra.0' uses dynamic stack allocation
 }
 ^
crypto/algif_aead.c: In function 'aead_recvmsg':
crypto/algif_aead.c:358:1: warning: 'aead_recvmsg' uses dynamic stack allocation
 }
 ^
crypto/ecc.c: In function 'ecc_gen_privkey':
crypto/ecc.c:984:1: warning: 'ecc_gen_privkey' uses dynamic stack allocation
 }
 ^
crypto/ecc.c: In function 'ecc_make_pub_key':
crypto/ecc.c:1020:1: warning: 'ecc_make_pub_key' uses dynamic stack allocation
 }
 ^
crypto/ecc.c: In function 'crypto_ecdh_shared_secret':
crypto/ecc.c:1070:1: warning: 'crypto_ecdh_shared_secret' uses dynamic stack allocation
 }
 ^
crypto/async_tx/async_pq.c: In function 'async_gen_syndrome':
crypto/async_tx/async_pq.c:266:1: warning: 'async_gen_syndrome' uses dynamic stack allocation
 }
 ^
crypto/async_tx/raid6test.c: In function 'raid6_dual_recov.constprop':
crypto/async_tx/raid6test.c:128:1: warning: 'raid6_dual_recov.constprop' uses dynamic stack allocation
 }
 ^
fs/nfs/super.c: In function 'nfs_show_stats':
fs/nfs/super.c:890:1: warning: 'nfs_show_stats' uses dynamic stack allocation
 }
 ^
drivers/scsi/ufs/ufshcd.c: In function 'ufs_get_device_desc':
drivers/scsi/ufs/ufshcd.c:6072:1: warning: 'ufs_get_device_desc' uses dynamic stack allocation
 }
 ^
drivers/scsi/ufs/ufshcd.c: In function 'ufshcd_probe_hba':
drivers/scsi/ufs/ufshcd.c:6448:1: warning: 'ufshcd_probe_hba' uses dynamic stack allocation
 }
 ^
drivers/scsi/dpt_i2o.c: In function 'adpt_i2o_passthru':
drivers/scsi/dpt_i2o.c:1894:1: warning: 'adpt_i2o_passthru' uses dynamic stack allocation
 }
 ^
fs/ntfs/compress.c: In function 'ntfs_read_compressed_block':
fs/ntfs/compress.c:960:1: warning: 'ntfs_read_compressed_block' uses dynamic stack allocation
 }
 ^
fs/ntfs/aops.c: In function 'ntfs_write_mst_block':
fs/ntfs/aops.c:1329:1: warning: 'ntfs_write_mst_block' uses dynamic stack allocation
 }
 ^
fs/ntfs/mft.c: In function 'ntfs_sync_mft_mirror':
fs/ntfs/mft.c:637:1: warning: 'ntfs_sync_mft_mirror' uses dynamic stack allocation
 }
 ^
fs/ntfs/mft.c: In function 'write_mft_record_nolock':
fs/ntfs/mft.c:845:1: warning: 'write_mft_record_nolock' uses dynamic stack allocation
 }
 ^
fs/pstore/ram_core.c: In function 'persistent_ram_decode_rs8.isra.6':
fs/pstore/ram_core.c:120:1: warning: 'persistent_ram_decode_rs8.isra.6' uses dynamic stack allocation
 }
 ^
fs/pstore/ram_core.c: In function 'persistent_ram_encode_rs8.isra.7':
fs/pstore/ram_core.c:108:1: warning: 'persistent_ram_encode_rs8.isra.7' uses dynamic stack allocation
 }
 ^
fs/nfsd/nfs4recover.c: In function 'nfs4_make_rec_clidname':
fs/nfsd/nfs4recover.c:147:1: warning: 'nfs4_make_rec_clidname' uses dynamic stack allocation
 }
 ^
fs/reiserfs/inode.c: In function 'reiserfs_new_inode':
fs/reiserfs/inode.c:2162:1: warning: 'reiserfs_new_inode' uses dynamic stack allocation
 }
 ^
drivers/gpu/drm/nouveau/nvkm/subdev/secboot/acr_r352.c: In function 'acr_r352_ls_write_wpr':
drivers/gpu/drm/nouveau/nvkm/subdev/secboot/acr_r352.c:451:1: warning: 'acr_r352_ls_write_wpr' uses dynamic stack allocation
 }
 ^
drivers/gpu/drm/nouveau/nvkm/subdev/secboot/ls_ucode_msgqueue.c: In function 'acr_ls_msgqueue_post_run':
drivers/gpu/drm/nouveau/nvkm/subdev/secboot/ls_ucode_msgqueue.c:100:1: warning: 'acr_ls_msgqueue_post_run' uses dynamic stack allocation
 }
 ^
drivers/gpu/drm/nouveau/nvkm/subdev/secboot/acr_r352.c: In function 'acr_r352_load':
drivers/gpu/drm/nouveau/nvkm/subdev/secboot/acr_r352.c:815:1: warning: 'acr_r352_load' uses dynamic stack allocation
 }
 ^
drivers/gpu/drm/nouveau/nvkm/subdev/secboot/acr_r367.c: In function 'acr_r367_ls_write_wpr':
drivers/gpu/drm/nouveau/nvkm/subdev/secboot/acr_r367.c:302:1: warning: 'acr_r367_ls_write_wpr' uses dynamic stack allocation
 }
 ^

--9jxsPFA5p3P2qPhR
Content-Type: text/plain; charset="utf-8"
Content-Disposition: attachment; filename="ppc64-20180201_104635.log"
Content-Transfer-Encoding: 8bit

=== Config /home/mhocko/work/build-test/configs/powerpc64/allmodconfig
drivers/android/binder_alloc.c: In function 'binder_alloc_shrinker_init':
drivers/android/binder_alloc.c:1008:2: warning: ignoring return value of 'register_shrinker', declared with attribute warn_unused_result [-Wunused-result]
  register_shrinker(&binder_shrinker);
  ^
In file included from samples/seccomp/bpf-fancy.c:21:0:
samples/seccomp/bpf-helper.h:135:2: error: #error __BITS_PER_LONG value unusable.
 #error __BITS_PER_LONG value unusable.
  ^
In file included from samples/seccomp/bpf-fancy.c:13:0:
samples/seccomp/bpf-fancy.c: In function ‘main’:
samples/seccomp/bpf-fancy.c:38:11: error: ‘__NR_exit’ undeclared (first use in this function)
   SYSCALL(__NR_exit, ALLOW),
           ^
./usr/include/linux/filter.h:52:69: note: in definition of macro ‘BPF_JUMP’
 #define BPF_JUMP(code, k, jt, jf) { (unsigned short)(code), jt, jf, k }
                                                                     ^
samples/seccomp/bpf-fancy.c:38:3: note: in expansion of macro ‘SYSCALL’
   SYSCALL(__NR_exit, ALLOW),
   ^
samples/seccomp/bpf-fancy.c:38:11: note: each undeclared identifier is reported only once for each function it appears in
   SYSCALL(__NR_exit, ALLOW),
           ^
./usr/include/linux/filter.h:52:69: note: in definition of macro ‘BPF_JUMP’
 #define BPF_JUMP(code, k, jt, jf) { (unsigned short)(code), jt, jf, k }
                                                                     ^
samples/seccomp/bpf-fancy.c:38:3: note: in expansion of macro ‘SYSCALL’
   SYSCALL(__NR_exit, ALLOW),
   ^
samples/seccomp/bpf-fancy.c:39:11: error: ‘__NR_exit_group’ undeclared (first use in this function)
   SYSCALL(__NR_exit_group, ALLOW),
           ^
./usr/include/linux/filter.h:52:69: note: in definition of macro ‘BPF_JUMP’
 #define BPF_JUMP(code, k, jt, jf) { (unsigned short)(code), jt, jf, k }
                                                                     ^
samples/seccomp/bpf-fancy.c:39:3: note: in expansion of macro ‘SYSCALL’
   SYSCALL(__NR_exit_group, ALLOW),
   ^
samples/seccomp/bpf-fancy.c:40:11: error: ‘__NR_write’ undeclared (first use in this function)
   SYSCALL(__NR_write, JUMP(&l, write_fd)),
           ^
./usr/include/linux/filter.h:52:69: note: in definition of macro ‘BPF_JUMP’
 #define BPF_JUMP(code, k, jt, jf) { (unsigned short)(code), jt, jf, k }
                                                                     ^
samples/seccomp/bpf-fancy.c:40:3: note: in expansion of macro ‘SYSCALL’
   SYSCALL(__NR_write, JUMP(&l, write_fd)),
   ^
samples/seccomp/bpf-fancy.c:41:11: error: ‘__NR_read’ undeclared (first use in this function)
   SYSCALL(__NR_read, JUMP(&l, read)),
           ^
./usr/include/linux/filter.h:52:69: note: in definition of macro ‘BPF_JUMP’
 #define BPF_JUMP(code, k, jt, jf) { (unsigned short)(code), jt, jf, k }
                                                                     ^
samples/seccomp/bpf-fancy.c:41:3: note: in expansion of macro ‘SYSCALL’
   SYSCALL(__NR_read, JUMP(&l, read)),
   ^
samples/seccomp/bpf-fancy.c:45:3: warning: implicit declaration of function ‘ARG’ [-Wimplicit-function-declaration]
   ARG(0),
   ^
samples/seccomp/bpf-fancy.c:45:3: warning: missing braces around initializer [-Wmissing-braces]
samples/seccomp/bpf-fancy.c:45:3: warning: (near initialization for ‘filter[11]’) [-Wmissing-braces]
samples/seccomp/bpf-fancy.c:46:3: warning: implicit declaration of function ‘JNE’ [-Wimplicit-function-declaration]
   JNE(STDIN_FILENO, DENY),
   ^
In file included from samples/seccomp/bpf-fancy.c:13:0:
./usr/include/linux/filter.h:49:27: error: expected expression before ‘{’ token
 #define BPF_STMT(code, k) { (unsigned short)(code), 0, 0, k }
                           ^
samples/seccomp/bpf-helper.h:48:2: note: in expansion of macro ‘BPF_STMT’
  BPF_STMT(BPF_RET+BPF_K, SECCOMP_RET_KILL)
  ^
samples/seccomp/bpf-fancy.c:46:21: note: in expansion of macro ‘DENY’
   JNE(STDIN_FILENO, DENY),
                     ^
./usr/include/linux/filter.h:49:27: error: expected expression before ‘{’ token
 #define BPF_STMT(code, k) { (unsigned short)(code), 0, 0, k }
                           ^
samples/seccomp/bpf-helper.h:48:2: note: in expansion of macro ‘BPF_STMT’
  BPF_STMT(BPF_RET+BPF_K, SECCOMP_RET_KILL)
  ^
samples/seccomp/bpf-fancy.c:48:27: note: in expansion of macro ‘DENY’
   JNE((unsigned long)buf, DENY),
                           ^
samples/seccomp/bpf-fancy.c:50:3: warning: implicit declaration of function ‘JGE’ [-Wimplicit-function-declaration]
   JGE(sizeof(buf), DENY),
   ^
In file included from samples/seccomp/bpf-fancy.c:13:0:
./usr/include/linux/filter.h:49:27: error: expected expression before ‘{’ token
 #define BPF_STMT(code, k) { (unsigned short)(code), 0, 0, k }
                           ^
samples/seccomp/bpf-helper.h:48:2: note: in expansion of macro ‘BPF_STMT’
  BPF_STMT(BPF_RET+BPF_K, SECCOMP_RET_KILL)
  ^
samples/seccomp/bpf-fancy.c:50:20: note: in expansion of macro ‘DENY’
   JGE(sizeof(buf), DENY),
                    ^
samples/seccomp/bpf-fancy.c:51:3: warning: braces around scalar initializer [enabled by default]
   ALLOW,
   ^
samples/seccomp/bpf-fancy.c:51:3: warning: (near initialization for ‘filter[12].jf’) [enabled by default]
samples/seccomp/bpf-fancy.c:51:3: warning: excess elements in scalar initializer [enabled by default]
samples/seccomp/bpf-fancy.c:51:3: warning: (near initialization for ‘filter[12].jf’) [enabled by default]
samples/seccomp/bpf-fancy.c:51:3: warning: excess elements in scalar initializer [enabled by default]
samples/seccomp/bpf-fancy.c:51:3: warning: (near initialization for ‘filter[12].jf’) [enabled by default]
samples/seccomp/bpf-fancy.c:51:3: warning: excess elements in scalar initializer [enabled by default]
samples/seccomp/bpf-fancy.c:51:3: warning: (near initialization for ‘filter[12].jf’) [enabled by default]
samples/seccomp/bpf-fancy.c:53:3: warning: braces around scalar initializer [enabled by default]
   LABEL(&l, write_fd),
   ^
samples/seccomp/bpf-fancy.c:53:3: warning: (near initialization for ‘filter[12].k’) [enabled by default]
samples/seccomp/bpf-fancy.c:53:3: warning: excess elements in scalar initializer [enabled by default]
samples/seccomp/bpf-fancy.c:53:3: warning: (near initialization for ‘filter[12].k’) [enabled by default]
samples/seccomp/bpf-fancy.c:53:3: warning: excess elements in scalar initializer [enabled by default]
samples/seccomp/bpf-fancy.c:53:3: warning: (near initialization for ‘filter[12].k’) [enabled by default]
samples/seccomp/bpf-fancy.c:53:3: warning: excess elements in scalar initializer [enabled by default]
samples/seccomp/bpf-fancy.c:53:3: warning: (near initialization for ‘filter[12].k’) [enabled by default]
samples/seccomp/bpf-fancy.c:55:3: warning: implicit declaration of function ‘JEQ’ [-Wimplicit-function-declaration]
   JEQ(STDOUT_FILENO, JUMP(&l, write_buf)),
   ^
In file included from samples/seccomp/bpf-fancy.c:13:0:
./usr/include/linux/filter.h:52:35: error: expected expression before ‘{’ token
 #define BPF_JUMP(code, k, jt, jf) { (unsigned short)(code), jt, jf, k }
                                   ^
samples/seccomp/bpf-helper.h:50:2: note: in expansion of macro ‘BPF_JUMP’
  BPF_JUMP(BPF_JMP+BPF_JA, FIND_LABEL((labels), (label)), \
  ^
samples/seccomp/bpf-fancy.c:55:22: note: in expansion of macro ‘JUMP’
   JEQ(STDOUT_FILENO, JUMP(&l, write_buf)),
                      ^
./usr/include/linux/filter.h:52:35: error: expected expression before ‘{’ token
 #define BPF_JUMP(code, k, jt, jf) { (unsigned short)(code), jt, jf, k }
                                   ^
samples/seccomp/bpf-helper.h:50:2: note: in expansion of macro ‘BPF_JUMP’
  BPF_JUMP(BPF_JMP+BPF_JA, FIND_LABEL((labels), (label)), \
  ^
samples/seccomp/bpf-fancy.c:56:22: note: in expansion of macro ‘JUMP’
   JEQ(STDERR_FILENO, JUMP(&l, write_buf)),
                      ^
samples/seccomp/bpf-fancy.c:57:3: warning: braces around scalar initializer [enabled by default]
   DENY,
   ^
samples/seccomp/bpf-fancy.c:57:3: warning: (near initialization for ‘filter[13].k’) [enabled by default]
samples/seccomp/bpf-fancy.c:57:3: warning: excess elements in scalar initializer [enabled by default]
samples/seccomp/bpf-fancy.c:57:3: warning: (near initialization for ‘filter[13].k’) [enabled by default]
samples/seccomp/bpf-fancy.c:57:3: warning: excess elements in scalar initializer [enabled by default]
samples/seccomp/bpf-fancy.c:57:3: warning: (near initialization for ‘filter[13].k’) [enabled by default]
samples/seccomp/bpf-fancy.c:57:3: warning: excess elements in scalar initializer [enabled by default]
samples/seccomp/bpf-fancy.c:57:3: warning: (near initialization for ‘filter[13].k’) [enabled by default]
In file included from samples/seccomp/bpf-fancy.c:13:0:
./usr/include/linux/filter.h:52:35: error: expected expression before ‘{’ token
 #define BPF_JUMP(code, k, jt, jf) { (unsigned short)(code), jt, jf, k }
                                   ^
samples/seccomp/bpf-helper.h:50:2: note: in expansion of macro ‘BPF_JUMP’
  BPF_JUMP(BPF_JMP+BPF_JA, FIND_LABEL((labels), (label)), \
  ^
samples/seccomp/bpf-fancy.c:61:28: note: in expansion of macro ‘JUMP’
   JEQ((unsigned long)msg1, JUMP(&l, msg1_len)),
                            ^
./usr/include/linux/filter.h:52:35: error: expected expression before ‘{’ token
 #define BPF_JUMP(code, k, jt, jf) { (unsigned short)(code), jt, jf, k }
                                   ^
samples/seccomp/bpf-helper.h:50:2: note: in expansion of macro ‘BPF_JUMP’
  BPF_JUMP(BPF_JMP+BPF_JA, FIND_LABEL((labels), (label)), \
  ^
samples/seccomp/bpf-fancy.c:62:28: note: in expansion of macro ‘JUMP’
   JEQ((unsigned long)msg2, JUMP(&l, msg2_len)),
                            ^
./usr/include/linux/filter.h:52:35: error: expected expression before ‘{’ token
 #define BPF_JUMP(code, k, jt, jf) { (unsigned short)(code), jt, jf, k }
                                   ^
samples/seccomp/bpf-helper.h:50:2: note: in expansion of macro ‘BPF_JUMP’
  BPF_JUMP(BPF_JMP+BPF_JA, FIND_LABEL((labels), (label)), \
  ^
samples/seccomp/bpf-fancy.c:63:27: note: in expansion of macro ‘JUMP’
   JEQ((unsigned long)buf, JUMP(&l, buf_len)),
                           ^
samples/seccomp/bpf-fancy.c:68:3: warning: implicit declaration of function ‘JLT’ [-Wimplicit-function-declaration]
   JLT(sizeof(msg1), ALLOW),
   ^
In file included from samples/seccomp/bpf-fancy.c:13:0:
./usr/include/linux/filter.h:49:27: error: expected expression before ‘{’ token
 #define BPF_STMT(code, k) { (unsigned short)(code), 0, 0, k }
                           ^
samples/seccomp/bpf-helper.h:46:2: note: in expansion of macro ‘BPF_STMT’
  BPF_STMT(BPF_RET+BPF_K, SECCOMP_RET_ALLOW)
  ^
samples/seccomp/bpf-fancy.c:68:21: note: in expansion of macro ‘ALLOW’
   JLT(sizeof(msg1), ALLOW),
                     ^
samples/seccomp/bpf-fancy.c:69:3: warning: braces around scalar initializer [enabled by default]
   DENY,
   ^
samples/seccomp/bpf-fancy.c:69:3: warning: (near initialization for ‘filter[18].jf’) [enabled by default]
samples/seccomp/bpf-fancy.c:69:3: warning: excess elements in scalar initializer [enabled by default]
samples/seccomp/bpf-fancy.c:69:3: warning: (near initialization for ‘filter[18].jf’) [enabled by default]
samples/seccomp/bpf-fancy.c:69:3: warning: excess elements in scalar initializer [enabled by default]
samples/seccomp/bpf-fancy.c:69:3: warning: (near initialization for ‘filter[18].jf’) [enabled by default]
samples/seccomp/bpf-fancy.c:69:3: warning: excess elements in scalar initializer [enabled by default]
samples/seccomp/bpf-fancy.c:69:3: warning: (near initialization for ‘filter[18].jf’) [enabled by default]
samples/seccomp/bpf-fancy.c:71:3: warning: braces around scalar initializer [enabled by default]
   LABEL(&l, msg2_len),
   ^
samples/seccomp/bpf-fancy.c:71:3: warning: (near initialization for ‘filter[18].k’) [enabled by default]
samples/seccomp/bpf-fancy.c:71:3: warning: excess elements in scalar initializer [enabled by default]
samples/seccomp/bpf-fancy.c:71:3: warning: (near initialization for ‘filter[18].k’) [enabled by default]
samples/seccomp/bpf-fancy.c:71:3: warning: excess elements in scalar initializer [enabled by default]
samples/seccomp/bpf-fancy.c:71:3: warning: (near initialization for ‘filter[18].k’) [enabled by default]
samples/seccomp/bpf-fancy.c:71:3: warning: excess elements in scalar initializer [enabled by default]
samples/seccomp/bpf-fancy.c:71:3: warning: (near initialization for ‘filter[18].k’) [enabled by default]
In file included from samples/seccomp/bpf-fancy.c:13:0:
./usr/include/linux/filter.h:49:27: error: expected expression before ‘{’ token
 #define BPF_STMT(code, k) { (unsigned short)(code), 0, 0, k }
                           ^
samples/seccomp/bpf-helper.h:46:2: note: in expansion of macro ‘BPF_STMT’
  BPF_STMT(BPF_RET+BPF_K, SECCOMP_RET_ALLOW)
  ^
samples/seccomp/bpf-fancy.c:73:21: note: in expansion of macro ‘ALLOW’
   JLT(sizeof(msg2), ALLOW),
                     ^
samples/seccomp/bpf-fancy.c:74:3: warning: braces around scalar initializer [enabled by default]
   DENY,
   ^
samples/seccomp/bpf-fancy.c:74:3: warning: (near initialization for ‘filter[19].jf’) [enabled by default]
samples/seccomp/bpf-fancy.c:74:3: warning: excess elements in scalar initializer [enabled by default]
samples/seccomp/bpf-fancy.c:74:3: warning: (near initialization for ‘filter[19].jf’) [enabled by default]
samples/seccomp/bpf-fancy.c:74:3: warning: excess elements in scalar initializer [enabled by default]
samples/seccomp/bpf-fancy.c:74:3: warning: (near initialization for ‘filter[19].jf’) [enabled by default]
samples/seccomp/bpf-fancy.c:74:3: warning: excess elements in scalar initializer [enabled by default]
samples/seccomp/bpf-fancy.c:74:3: warning: (near initialization for ‘filter[19].jf’) [enabled by default]
samples/seccomp/bpf-fancy.c:76:3: warning: braces around scalar initializer [enabled by default]
   LABEL(&l, buf_len),
   ^
samples/seccomp/bpf-fancy.c:76:3: warning: (near initialization for ‘filter[19].k’) [enabled by default]
samples/seccomp/bpf-fancy.c:76:3: warning: excess elements in scalar initializer [enabled by default]
samples/seccomp/bpf-fancy.c:76:3: warning: (near initialization for ‘filter[19].k’) [enabled by default]
samples/seccomp/bpf-fancy.c:76:3: warning: excess elements in scalar initializer [enabled by default]
samples/seccomp/bpf-fancy.c:76:3: warning: (near initialization for ‘filter[19].k’) [enabled by default]
samples/seccomp/bpf-fancy.c:76:3: warning: excess elements in scalar initializer [enabled by default]
samples/seccomp/bpf-fancy.c:76:3: warning: (near initialization for ‘filter[19].k’) [enabled by default]
In file included from samples/seccomp/bpf-fancy.c:13:0:
./usr/include/linux/filter.h:49:27: error: expected expression before ‘{’ token
 #define BPF_STMT(code, k) { (unsigned short)(code), 0, 0, k }
                           ^
samples/seccomp/bpf-helper.h:46:2: note: in expansion of macro ‘BPF_STMT’
  BPF_STMT(BPF_RET+BPF_K, SECCOMP_RET_ALLOW)
  ^
samples/seccomp/bpf-fancy.c:78:20: note: in expansion of macro ‘ALLOW’
   JLT(sizeof(buf), ALLOW),
                    ^
samples/seccomp/bpf-fancy.c:79:3: warning: braces around scalar initializer [enabled by default]
   DENY,
   ^
samples/seccomp/bpf-fancy.c:79:3: warning: (near initialization for ‘filter[20].jf’) [enabled by default]
samples/seccomp/bpf-fancy.c:79:3: warning: excess elements in scalar initializer [enabled by default]
samples/seccomp/bpf-fancy.c:79:3: warning: (near initialization for ‘filter[20].jf’) [enabled by default]
samples/seccomp/bpf-fancy.c:79:3: warning: excess elements in scalar initializer [enabled by default]
samples/seccomp/bpf-fancy.c:79:3: warning: (near initialization for ‘filter[20].jf’) [enabled by default]
samples/seccomp/bpf-fancy.c:79:3: warning: excess elements in scalar initializer [enabled by default]
samples/seccomp/bpf-fancy.c:79:3: warning: (near initialization for ‘filter[20].jf’) [enabled by default]
samples/seccomp/bpf-fancy.c:97:2: warning: passing argument 1 of ‘syscall’ makes integer from pointer without a cast [enabled by default]
  syscall(__NR_write, STDOUT_FILENO, msg1, strlen(msg1));
  ^
In file included from samples/seccomp/bpf-fancy.c:19:0:
/usr/include/unistd.h:1061:17: note: expected ‘long int’ but argument is of type ‘struct sock_filter *’
 extern long int syscall (long int __sysno, ...) __THROW;
                 ^
samples/seccomp/bpf-fancy.c:98:2: warning: passing argument 1 of ‘syscall’ makes integer from pointer without a cast [enabled by default]
  bytes = syscall(__NR_read, STDIN_FILENO, buf, sizeof(buf)-1);
  ^
In file included from samples/seccomp/bpf-fancy.c:19:0:
/usr/include/unistd.h:1061:17: note: expected ‘long int’ but argument is of type ‘struct sock_filter *’
 extern long int syscall (long int __sysno, ...) __THROW;
                 ^
samples/seccomp/bpf-fancy.c:100:2: warning: passing argument 1 of ‘syscall’ makes integer from pointer without a cast [enabled by default]
  syscall(__NR_write, STDERR_FILENO, msg2, strlen(msg2));
  ^
In file included from samples/seccomp/bpf-fancy.c:19:0:
/usr/include/unistd.h:1061:17: note: expected ‘long int’ but argument is of type ‘struct sock_filter *’
 extern long int syscall (long int __sysno, ...) __THROW;
                 ^
samples/seccomp/bpf-fancy.c:101:2: warning: passing argument 1 of ‘syscall’ makes integer from pointer without a cast [enabled by default]
  syscall(__NR_write, STDERR_FILENO, buf, bytes);
  ^
In file included from samples/seccomp/bpf-fancy.c:19:0:
/usr/include/unistd.h:1061:17: note: expected ‘long int’ but argument is of type ‘struct sock_filter *’
 extern long int syscall (long int __sysno, ...) __THROW;
                 ^
samples/seccomp/bpf-fancy.c:103:2: warning: passing argument 1 of ‘syscall’ makes integer from pointer without a cast [enabled by default]
  syscall(__NR_write, STDERR_FILENO, msg2, strlen(msg2)+2);
  ^
In file included from samples/seccomp/bpf-fancy.c:19:0:
/usr/include/unistd.h:1061:17: note: expected ‘long int’ but argument is of type ‘struct sock_filter *’
 extern long int syscall (long int __sysno, ...) __THROW;
                 ^
make[2]: *** [samples/seccomp/bpf-fancy.o] Error 1
make[2]: *** Waiting for unfinished jobs....
In file included from samples/seccomp/bpf-helper.c:17:0:
samples/seccomp/bpf-helper.h:135:2: error: #error __BITS_PER_LONG value unusable.
 #error __BITS_PER_LONG value unusable.
  ^
make[2]: *** [samples/seccomp/bpf-helper.o] Error 1
make[1]: *** [samples/seccomp] Error 2
make[1]: *** Waiting for unfinished jobs....
make: *** [samples] Error 2
make: *** Waiting for unfinished jobs....
drivers/staging/android/ashmem.c: In function 'ashmem_init':
drivers/staging/android/ashmem.c:867:2: warning: ignoring return value of 'register_shrinker', declared with attribute warn_unused_result [-Wunused-result]
  register_shrinker(&ashmem_shrinker);
  ^
drivers/staging/android/ion/ion_heap.c: In function 'ion_heap_init_shrinker':
drivers/staging/android/ion/ion_heap.c:315:2: warning: ignoring return value of 'register_shrinker', declared with attribute warn_unused_result [-Wunused-result]
  register_shrinker(&heap->shrinker);
  ^

--9jxsPFA5p3P2qPhR--
